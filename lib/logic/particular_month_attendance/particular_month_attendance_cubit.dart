import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/particular_month_attendance/particular_month_attendance_state.dart';
import 'package:nguru/repo/api_calls.dart';

class ParticularMonthAttendanceCubit
    extends Cubit<ParticularMonthAttendanceState> {
  final AuthRepo? authRepo;

  ParticularMonthAttendanceCubit(this.authRepo)
      : super(ParticularMonthAttendanceLoadingState());

  Future<void> getParticularMonthAttendance(int monthNumber) async {
    try {
      emit(ParticularMonthAttendanceLoadingState());
      final result = await authRepo?.getParticularMonthAttendance(monthNumber: monthNumber);
      if (result != null) {
        if (result.responseCode == "200") {
          emit(ParticularMonthAttendanceSuccessState(
              particularMonthAttendanceModel: result));
        } else {
          emit(ParticularMonthAttendanceErrorState(
              result.responseMessage ?? "Error occured"));
        }
        log("$result");
      }
    } catch (e) {
      emit(ParticularMonthAttendanceErrorState(e.toString()));
    }
  }
}
