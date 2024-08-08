

import 'package:nguru/models/calendar_event_model.dart';

// abstract class CalendarEventState {}

// class CalendarEventInitialState extends CalendarEventState {}

// class CalendarEventLoadingState extends CalendarEventState {}

// class CalendarEventSuccessState extends CalendarEventState {
//   final List<CalendarEventList>? calendarEventList;
//   final List<CalendarEventList> calendarEventListData;
//    CalendarEventSuccessState({   
//     this.calendarEventList ,
//     required this.calendarEventListData
//     });
// }



// class CalendarEventErrorState extends CalendarEventState {
//   final String message;
//   CalendarEventErrorState(this.message);
// }


import 'package:equatable/equatable.dart';

abstract class CalendarEventState extends Equatable {
  final List<CalendarEventList>? myVariable;

  const CalendarEventState({this.myVariable});

  @override
  List<Object?> get props => [myVariable];

  // Allows copying the state with new values
  CalendarEventState copyWith({List<CalendarEventList>? myVariable});
}

class CalendarEventInitialState extends CalendarEventState {
  const CalendarEventInitialState({List<CalendarEventList>? myVariable}) : super(myVariable: myVariable);

  @override
  CalendarEventState copyWith({List<CalendarEventList>? myVariable}) {
    return CalendarEventInitialState(myVariable: myVariable ?? this.myVariable);
  }
}

class CalendarEventLoadingState extends CalendarEventState {
  const CalendarEventLoadingState({List<CalendarEventList>? myVariable}) : super(myVariable: myVariable);

  @override
  CalendarEventState copyWith({List<CalendarEventList>? myVariable}) {
    return CalendarEventLoadingState(myVariable: myVariable ?? this.myVariable);
  }
}

class CalendarEventSuccessState extends CalendarEventState {
  final List<CalendarEventList>? calendarEventList;
  final List<CalendarEventList> calendarEventListData;

  const CalendarEventSuccessState({
    required this.calendarEventListData,
    this.calendarEventList,
    List<CalendarEventList>? myVariable,
  }) : super(myVariable: myVariable);

  @override
  CalendarEventState copyWith({List<CalendarEventList>? myVariable, List<CalendarEventList>? calendarEventList}) {
    return CalendarEventSuccessState(
      
      calendarEventList: calendarEventList ?? this.calendarEventList,
      myVariable: myVariable ?? this.myVariable, calendarEventListData: [],
    );
  }

  @override
  List<Object?> get props => [calendarEventList, myVariable];
}

class CalendarEventErrorState extends CalendarEventState {
  final String message;

  const CalendarEventErrorState(this.message, {List<CalendarEventList>? myVariable}) : super(myVariable: myVariable);

  @override
  CalendarEventState copyWith({List<CalendarEventList>? myVariable}) {
    return CalendarEventErrorState(message, myVariable: myVariable );
  }

  @override
  List<Object?> get props => [message, myVariable];
}
