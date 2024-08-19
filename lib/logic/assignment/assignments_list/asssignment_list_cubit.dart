import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/assignment/assignments_list/assignment_list_state.dart';
import 'package:nguru/repo/api_calls.dart';

class AssignmentListCubit extends Cubit<AssignmentListState> {
  final AuthRepo? authRepo;

  AssignmentListCubit(this.authRepo) : super(AssignmentListLoadingState());

  Future<void> getAssignmentList(int? month, String ?assignmentOnParticularDate) async {
    try {
      emit(AssignmentListLoadingState());
      final result = await authRepo?.getAssignementList(month: month, assignmentOnParticularDate: assignmentOnParticularDate);
      if (result != null) {
        if (result.responseCode == "200") {
          emit(AssignmentListSuccessState(subjectList: result.subjectList ?? []));
        } else {
          emit(AssignmentListErrorState(result.responseMessage ?? "Error occurred"));
        }
        log("${result.subjectList}");
      } else {
        emit(AssignmentListErrorState("No result received from API"));
      }
    } catch (e) {
      emit(AssignmentListErrorState(e.toString()));
    }
  }
}
