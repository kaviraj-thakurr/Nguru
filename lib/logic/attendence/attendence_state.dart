import 'package:nguru/models/attendence_model.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceLoaded extends AttendanceState {
  final AttendanceData attendanceData;

  AttendanceLoaded(this.attendanceData);
}

class AttendanceError extends AttendanceState {
  final String message;

  AttendanceError(this.message);
}