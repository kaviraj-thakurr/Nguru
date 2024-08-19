import 'package:nguru/models/timetable_model.dart';

abstract class TimeTableState {}
class TimeTableInitState extends TimeTableState {}

class TimeTableLoadingState extends TimeTableState {}

class TimeTableSuccessState extends TimeTableState {
  final TimeTableModel timeTableModel;
  TimeTableSuccessState(this.timeTableModel);
}

class TimeTableErrorState extends TimeTableState {
  final String message;
  TimeTableErrorState(this.message);
}
