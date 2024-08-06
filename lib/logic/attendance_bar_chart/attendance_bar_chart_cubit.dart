import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nguru/logic/attendance_bar_chart/attendance_bar_chart_state.dart';
import 'package:nguru/repo/api_calls.dart';

class AttendanceBarChartCubit extends Cubit<AttendanceBarChartState> {
  final AuthRepo?  authRepo;


  AttendanceBarChartCubit(this.authRepo) : super(AttendanceBarChartLoadingState());


  Future<void> getAttendanceBarChart() async {
    try {
      emit(AttendanceBarChartLoadingState());
      final result = await authRepo?.getAttendanceBarGraph();
      if (result != null) {
        if(result.responseCode == "200" ){
          emit(AttendanceBarChartSuccessState(attendanceBarChart: result.attendanceBarChart ?? []));
        }else {
emit(AttendanceBarChartErrorState(result.responseMessage ?? "Error occured"));
        }
        log("${result.attendanceBarChart}");
        
      }
    } catch (e) {
      emit(AttendanceBarChartErrorState(e.toString()));
    }
  }
}



