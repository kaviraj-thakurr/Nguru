import 'package:nguru/models/attendance_bar_chart_model.dart';

abstract class AttendanceBarChartState {}

class AttendanceBarChartInitialState extends AttendanceBarChartState {}

class AttendanceBarChartLoadingState extends AttendanceBarChartState {}

class AttendanceBarChartSuccessState extends AttendanceBarChartState {
  final List<AttendanceBarChart> attendanceBarChart;
   AttendanceBarChartSuccessState({  required this.attendanceBarChart});
}

class AttendanceBarChartErrorState extends AttendanceBarChartState {
  final String message;
  AttendanceBarChartErrorState(this.message);
}