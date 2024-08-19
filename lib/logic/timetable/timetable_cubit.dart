import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/repo/api_calls.dart';
import 'package:nguru/logic/timetable/timetable_state.dart';

class TimeTableCubit extends Cubit<TimeTableState> {
  final AuthRepo? authRepo;

  TimeTableCubit(this.authRepo) : super(TimeTableInitState());

  Future<void> getTimeTableList() async {
    try {
      emit(TimeTableLoadingState());
      final result = await authRepo?.getTimeTableList();
      if (result != null) {
        if (result.responseCode == "200") {
          emit(TimeTableSuccessState(result));
        } else {
          emit(TimeTableErrorState(result.responseMessage ?? "Error occurred"));
        }
      }
    } catch (e) {
      emit(TimeTableErrorState(e.toString()));
    }
  }
}
