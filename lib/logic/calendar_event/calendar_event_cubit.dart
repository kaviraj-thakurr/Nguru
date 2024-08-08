import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/calendar_event/calendar_event_state.dart';
import 'package:nguru/models/calendar_event_model.dart';
import 'package:nguru/repo/api_calls.dart';

class CalendarEventCubit extends Cubit<CalendarEventState> {
  final AuthRepo? authRepo;

  CalendarEventCubit(this.authRepo) : super(const CalendarEventInitialState());

  Future<void> getCalendarEvent(int monthNumber) async {
    try {
      emit(const CalendarEventLoadingState());
      final result = await authRepo?.getCalendarEventList(monthNumber: monthNumber);
      if (result != null) {
        if (result.responseCode == "200") {
          emit(CalendarEventSuccessState(
              calendarEventList: result.calendarEventList ?? [], myVariable: state.myVariable, calendarEventListData: []));
        } else {
          emit(CalendarEventErrorState(result.responseMessage ?? "Error occurred", myVariable: state.myVariable));
        }
      }
    } catch (e) {
      emit(CalendarEventErrorState(e.toString(), myVariable: state.myVariable));
    }
  }

  // Future<void> getCalendarEventData(List<CalendarEventList> calendarEventList) async {
  //   emit(CalendarEventSuccessState(calendarEventList: calendarEventList, myVariable: state.myVariable, calendarEventListData: []));
  // }

  void setMyVariable(List<CalendarEventList> value) {
    emit(state.copyWith(myVariable: value));
  }

  List<CalendarEventList> getMyVariable() {
    return state.myVariable ?? [];
}

}