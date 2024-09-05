import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/examination/exam_marks/exam_marks_state.dart';

import 'package:nguru/repo/api_calls.dart';


class ExamMarksListCubit extends Cubit<ExamMarksListState> {
  final AuthRepo? authRepo;

  ExamMarksListCubit(this.authRepo) : super(ExamMarksListInitState());

  Future<void> getExamMarks() async {
    try {
      emit(ExamMarksListLoadingState());
      final result = await authRepo?.getExamMarks();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(ExamMarksListSuccessState(result));
        } else {
          emit(ExamMarksListErrorState(result.responseMessage ?? "Error occurred"));
        }
      }
    } catch (e) {
      emit(ExamMarksListErrorState(e.toString()));
    }
  }
}
