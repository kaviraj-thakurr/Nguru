

import 'package:nguru/models/calendar_event_model.dart';

abstract class CalendarEventState {}

class CalendarEventInitialState extends CalendarEventState {}

class CalendarEventLoadingState extends CalendarEventState {}

class CalendarEventSuccessState extends CalendarEventState {
  final List<CalendarEventList>? calendarEventList;
  final List<CalendarEventList> calendarEventListData;
   CalendarEventSuccessState({   
    this.calendarEventList ,
    required this.calendarEventListData
    });
}

class CalendarEventFilteredState extends CalendarEventState {
  final List<CalendarEventList>? calendarEventFilteredList;
   CalendarEventFilteredState({   
    this.calendarEventFilteredList,
    });
}


class CalendarEventErrorState extends CalendarEventState {
  final String message;
  CalendarEventErrorState(this.message);
}


