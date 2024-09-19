
import 'package:nguru/models/cumulative_attendance_model.dart';

abstract class CumulativeAttendanceState {}

class CumulativeAttendanceInitial extends CumulativeAttendanceState {}

class CumulativeAttendanceLoadingState extends CumulativeAttendanceState {}

class CumulativeAttendanceSuccessState extends CumulativeAttendanceState {
  final List<AttendanceCumulativeModel> attendanceCumulativeModel;
   int? totalWorkingDaysSessional;

  CumulativeAttendanceSuccessState( {required this.attendanceCumulativeModel,  this.totalWorkingDaysSessional});



   CumulativeAttendanceSuccessState copyWith({
      final List<AttendanceCumulativeModel>? attendanceCumulativeModel,
      final int? totalWorkingDaysSessional,
  }) {
    return CumulativeAttendanceSuccessState(
      attendanceCumulativeModel: attendanceCumulativeModel ?? this.attendanceCumulativeModel,
      totalWorkingDaysSessional: totalWorkingDaysSessional ?? this.totalWorkingDaysSessional,
    );
  }
}

class CumulativeAttendanceErrorState extends CumulativeAttendanceState {
  final String message;

  CumulativeAttendanceErrorState(this.message);
}