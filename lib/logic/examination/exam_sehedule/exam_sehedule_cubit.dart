import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/examination/exam_sehedule/exam_sehedule_state.dart';
import 'package:nguru/repo/api_calls.dart';


class ExamScheduleListCubit extends Cubit<ExamScheduleListState> {
  final AuthRepo? authRepo;

  ExamScheduleListCubit(this.authRepo) : super(ExamScheduleListInitState());

  Future<void> getScheduleList() async {
    try {
      emit(ExamScheduleListLoadingState());
      final result = await authRepo?.getScheduleList();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(ExamScheduleListSuccessState(result));
        } else {
          emit(ExamScheduleListErrorState(result.responseMessage ?? "Error occurred"));
        }
      }
    } catch (e) {
      emit(ExamScheduleListErrorState(e.toString()));
    }
  }
}
