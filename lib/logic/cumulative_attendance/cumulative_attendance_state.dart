
import 'package:nguru/models/cumulative_attendance_model.dart';

abstract class CumulativeAttendanceState {}

class CumulativeAttendanceInitial extends CumulativeAttendanceState {}

class CumulativeAttendanceLoadingState extends CumulativeAttendanceState {}

class CumulativeAttendanceSuccessState extends CumulativeAttendanceState {
  final List<AttendanceCumulativeModel>? attendanceCumulativeModel;

  CumulativeAttendanceSuccessState(this.attendanceCumulativeModel);
}

class CumulativeAttendanceErrorState extends CumulativeAttendanceState {
  final String message;

  CumulativeAttendanceErrorState(this.message);
}