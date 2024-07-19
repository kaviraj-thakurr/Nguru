class AttendanceData {
  int studentID;
  String studentName;
  String enrollmentNo;
  String studentPicture;
  List<AttendanceBarChart> attendanceBarChart;
  String responseCode;
  String responseMessage;

  AttendanceData({
    required this.studentID,
    required this.studentName,
    required this.enrollmentNo,
    required this.studentPicture,
    required this.attendanceBarChart,
    required this.responseCode,
    required this.responseMessage,
  });

  factory AttendanceData.fromJson(Map<String, dynamic> json) {
    var list = json['attendanceBarChart'] as List;
    List<AttendanceBarChart> attendanceBarChartList = list.map((i) => AttendanceBarChart.fromJson(i)).toList();

    return AttendanceData(
      studentID: json['studentID'],
      studentName: json['studentName'],
      enrollmentNo: json['enrollmentNo'],
      studentPicture: json['studentPicture'],
      attendanceBarChart: attendanceBarChartList,
      responseCode: json['responseCode'],
      responseMessage: json['responseMessage'],
    );
  }

  double getTotalAttendancePercentage() {
    if (attendanceBarChart.isEmpty) return 0.0;
    double total = attendanceBarChart.fold(0.0, (sum, item) => sum + double.parse(item.attendancePercent));
    return total / attendanceBarChart.length;
  }
}

class AttendanceBarChart {
  int month;
  String monthName;
  String attendancePercent;
  String date;

  AttendanceBarChart({
    required this.month,
    required this.monthName,
    required this.attendancePercent,
    required this.date,
  });

  factory AttendanceBarChart.fromJson(Map<String, dynamic> json) {
    return AttendanceBarChart(
      month: json['month'],
      monthName: json['monthName'],
      attendancePercent: json['attendancePercent'],
      date: json['date'],
    );
  }
}
