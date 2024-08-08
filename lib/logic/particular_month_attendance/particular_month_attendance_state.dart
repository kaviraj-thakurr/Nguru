
import 'package:nguru/models/particular_month_attendance_model.dart';

abstract class ParticularMonthAttendanceState {}

class ParticularMonthAttendanceInitialState extends ParticularMonthAttendanceState {}

class ParticularMonthAttendanceLoadingState extends ParticularMonthAttendanceState {}

class ParticularMonthAttendanceSuccessState extends ParticularMonthAttendanceState {
  final ParticularMonthAttendanceModel particularMonthAttendanceModel;
   ParticularMonthAttendanceSuccessState({  required this.particularMonthAttendanceModel});
}

class ParticularMonthAttendanceErrorState extends ParticularMonthAttendanceState {
  final String message;
  ParticularMonthAttendanceErrorState(this.message);
}