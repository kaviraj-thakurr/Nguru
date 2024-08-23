import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/calendar_event/calendar_event_state.dart';
import 'package:nguru/models/calendar_event_model.dart';
import 'package:nguru/repo/api_calls.dart';

class CalendarEventCubit extends Cubit<CalendarEventState> {
  final AuthRepo? authRepo;
    List<CalendarEventList> calendarEventList = [];

  CalendarEventCubit(this.authRepo) : super( CalendarEventInitialState());

  Future<void> getCalendarEvent(int monthNumber) async {
    try {
      emit( CalendarEventLoadingState());
      final result = await authRepo?.getCalendarEventList(monthNumber: monthNumber);
      if (result != null) {
        if (result.responseCode == "200") {
          emit(CalendarEventSuccessState(calendarEventList: result.calendarEventList ?? [], calendarEventListData: []));
            calendarEventList =   getAllEventsWithStatusOne( result.calendarEventList ?? []);
              log(calendarEventList.toString());
        } else {
          emit(CalendarEventErrorState(result.responseMessage ?? "Error occurred",));
        }
      }
    } catch (e) {
      emit(CalendarEventErrorState(e.toString()));
    }
  }

List<CalendarEventList> getAllEventsWithStatusOne(List<CalendarEventList> allEvents) {
  // Filtering the list to get only the events that have status == 1
  return allEvents.where((event) => event.details == "1" || event.details == "0").toList();
}


}