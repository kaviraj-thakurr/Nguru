import 'package:nguru/models/attendence_model.dart';

abstract class AttendanceState {}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoading extends AttendanceState {}

class AttendanceSuccess extends AttendanceState {
  final String overAllPercentage;

  AttendanceSuccess(this.overAllPercentage);
}

class AttendanceError extends AttendanceState {
  final String message;

  AttendanceError(this.message);
}