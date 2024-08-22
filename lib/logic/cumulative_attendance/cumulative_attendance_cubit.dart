

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/cumulative_attendance/cumulative_attendance_state.dart';
import 'package:nguru/repo/api_calls.dart';

  // int totalWorkingDays = 0;
class CumulativeAttendanceCubit extends Cubit<CumulativeAttendanceState> {
  final AuthRepo?  authRepo;
  


  CumulativeAttendanceCubit(this.authRepo) : super(CumulativeAttendanceLoadingState());


  Future<void> getCumulativeAttendance() async {
    try {
      emit(CumulativeAttendanceLoadingState());
      final result = await authRepo?.getCumulativeAttendance();
      if (result != null) {
        if(result.responseCode == "200" ){

         

                              // for (int i = 0;
                              //     i <result.attendanceCumulativeModel!.length;
                              //     i++) {
                              //   totalWorkingDays = totalWorkingDays +
                              //       int.parse(result.attendanceCumulativeModel![i]
                              //           .workingDays
                              //           .toString());
                              // }
          emit(CumulativeAttendanceSuccessState( result.attendanceCumulativeModel ));
        }else {
emit(CumulativeAttendanceErrorState(result.responseMessage ?? "Error occured"));
        }
        log("${result.attendanceCumulativeModel?.length}");
        
      }
    } catch (e) {
      emit(CumulativeAttendanceErrorState(e.toString()));
    }
  }
}



