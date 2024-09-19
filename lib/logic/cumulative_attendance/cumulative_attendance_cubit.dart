import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/cumulative_attendance/cumulative_attendance_state.dart';
import 'package:nguru/models/cumulative_attendance_model.dart';
import 'package:nguru/repo/api_calls.dart';

class CumulativeAttendanceCubit extends Cubit<CumulativeAttendanceState> {
  final AuthRepo? authRepo;
  int totalWorkingDaysSessional = 0; 
  List<AttendanceCumulativeModel> attendanceVerticalGraph=[];
  CumulativeAttendanceModel? result;

  CumulativeAttendanceCubit(this.authRepo)
      : super(CumulativeAttendanceInitial());

  Future<void> getCumulativeAttendance() async {
    try {
      emit(CumulativeAttendanceLoadingState()); 

      result = await authRepo?.getCumulativeAttendance();
      if (result != null) {
        if (result?.responseCode == "200") {
          attendanceVerticalGraph=result?.attendanceCumulativeModel?? [];
          emit(CumulativeAttendanceSuccessState(
            attendanceCumulativeModel: result?.attendanceCumulativeModel ?? [],
          ));
        } else {
          emit(CumulativeAttendanceErrorState(result?.responseMessage ?? "Error occurred"));
        }
      }
    } catch (e) {
      emit(CumulativeAttendanceErrorState(e.toString()));
    }
  }
  Future<void> getTotalWorkingDaysSessional() async {
    try {
      if (result != null && result?.responseCode == "200") {
        int updatedWorkingDays = 0;
        for (var model in result!.attendanceCumulativeModel!) {
          updatedWorkingDays += int.parse(model.workingDays.toString());
        }

        totalWorkingDaysSessional = updatedWorkingDays;

        if (state is CumulativeAttendanceSuccessState) {
          final currentState = state as CumulativeAttendanceSuccessState;
          emit(currentState.copyWith(totalWorkingDaysSessional: totalWorkingDaysSessional));
        }
      } else {
        emit(CumulativeAttendanceErrorState(result!.responseMessage ?? "Error occurred"));
      }
    } catch (e) {
      emit(CumulativeAttendanceErrorState(e.toString()));
    }
  }
}
