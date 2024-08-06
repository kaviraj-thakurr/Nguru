// To parse this JSON data, do
//
//     final attendanceBarChartModel = attendanceBarChartModelFromJson(jsonString);

import 'dart:convert';

AttendanceBarChartModel attendanceBarChartModelFromJson(String str) => AttendanceBarChartModel.fromJson(json.decode(str));

String attendanceBarChartModelToJson(AttendanceBarChartModel data) => json.encode(data.toJson());

class AttendanceBarChartModel {
    int? studentId;
    String? studentName;
    String? enrollmentNo;
    String? studentPicture;
    List<AttendanceBarChart>? attendanceBarChart;
    String? responseCode;
    String? responseMessage;

    AttendanceBarChartModel({
        this.studentId,
        this.studentName,
        this.enrollmentNo,
        this.studentPicture,
        this.attendanceBarChart,
        this.responseCode,
        this.responseMessage,
    });

    AttendanceBarChartModel copyWith({
        int? studentId,
        String? studentName,
        String? enrollmentNo,
        String? studentPicture,
        List<AttendanceBarChart>? attendanceBarChart,
        String? responseCode,
        String? responseMessage,
    }) => 
        AttendanceBarChartModel(
            studentId: studentId ?? this.studentId,
            studentName: studentName ?? this.studentName,
            enrollmentNo: enrollmentNo ?? this.enrollmentNo,
            studentPicture: studentPicture ?? this.studentPicture,
            attendanceBarChart: attendanceBarChart ?? this.attendanceBarChart,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory AttendanceBarChartModel.fromJson(Map<String, dynamic> json) => AttendanceBarChartModel(
        studentId: json["studentID"],
        studentName: json["studentName"],
        enrollmentNo: json["enrollmentNo"],
        studentPicture: json["studentPicture"],
        attendanceBarChart: json["attendanceBarChart"] == null ? [] : List<AttendanceBarChart>.from(json["attendanceBarChart"]!.map((x) => AttendanceBarChart.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "studentID": studentId,
        "studentName": studentName,
        "enrollmentNo": enrollmentNo,
        "studentPicture": studentPicture,
        "attendanceBarChart": attendanceBarChart == null ? [] : List<dynamic>.from(attendanceBarChart!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class AttendanceBarChart {
    int? month;
    String? monthName;
    String? attendancePercent;
    DateTime? date;

    AttendanceBarChart({
        this.month,
        this.monthName,
        this.attendancePercent,
        this.date,
    });

    AttendanceBarChart copyWith({
        int? month,
        String? monthName,
        String? attendancePercent,
        DateTime? date,
    }) => 
        AttendanceBarChart(
            month: month ?? this.month,
            monthName: monthName ?? this.monthName,
            attendancePercent: attendancePercent ?? this.attendancePercent,
            date: date ?? this.date,
        );

    factory AttendanceBarChart.fromJson(Map<String, dynamic> json) => AttendanceBarChart(
        month: json["month"],
        monthName: json["monthName"],
        attendancePercent: json["attendancePercent"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toJson() => {
        "month": month,
        "monthName": monthName,
        "attendancePercent": attendancePercent,
        "date": date?.toIso8601String(),
    };
}
