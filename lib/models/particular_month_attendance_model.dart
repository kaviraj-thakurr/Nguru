// To parse this JSON data, do
//
//     final particularMonthAttendanceModel = particularMonthAttendanceModelFromJson(jsonString);

import 'dart:convert';

ParticularMonthAttendanceModel particularMonthAttendanceModelFromJson(String str) => ParticularMonthAttendanceModel.fromJson(json.decode(str));

String particularMonthAttendanceModelToJson(ParticularMonthAttendanceModel data) => json.encode(data.toJson());

class ParticularMonthAttendanceModel {
    List<AttendanceMonth>? attendanceMonth;
    int? presentCount;
    int? absentCount;
    int? leaveCount;
    int? firsthalfCount;
    int? secondhalfCount;
    int? holidayCount;
    String? responseCode;
    String? responseMessage;

    ParticularMonthAttendanceModel({
        this.attendanceMonth,
        this.presentCount,
        this.absentCount,
        this.leaveCount,
        this.firsthalfCount,
        this.secondhalfCount,
        this.holidayCount,
        this.responseCode,
        this.responseMessage,
    });

    ParticularMonthAttendanceModel copyWith({
        List<AttendanceMonth>? attendanceMonth,
        int? presentCount,
        int? absentCount,
        int? leaveCount,
        int? firsthalfCount,
        int? secondhalfCount,
        int? holidayCount,
        String? responseCode,
        String? responseMessage,
    }) => 
        ParticularMonthAttendanceModel(
            attendanceMonth: attendanceMonth ?? this.attendanceMonth,
            presentCount: presentCount ?? this.presentCount,
            absentCount: absentCount ?? this.absentCount,
            leaveCount: leaveCount ?? this.leaveCount,
            firsthalfCount: firsthalfCount ?? this.firsthalfCount,
            secondhalfCount: secondhalfCount ?? this.secondhalfCount,
            holidayCount: holidayCount ?? this.holidayCount,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory ParticularMonthAttendanceModel.fromJson(Map<String, dynamic> json) => ParticularMonthAttendanceModel(
        attendanceMonth: json["attendanceMonth"] == null ? [] : List<AttendanceMonth>.from(json["attendanceMonth"]!.map((x) => AttendanceMonth.fromJson(x))),
        presentCount: json["presentCount"],
        absentCount: json["absentCount"],
        leaveCount: json["leaveCount"],
        firsthalfCount: json["firsthalfCount"],
        secondhalfCount: json["secondhalfCount"],
        holidayCount: json["holidayCount"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "attendanceMonth": attendanceMonth == null ? [] : List<dynamic>.from(attendanceMonth!.map((x) => x.toJson())),
        "presentCount": presentCount,
        "absentCount": absentCount,
        "leaveCount": leaveCount,
        "firsthalfCount": firsthalfCount,
        "secondhalfCount": secondhalfCount,
        "holidayCount": holidayCount,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class AttendanceMonth {
    int? dayKey;
    int? status;
    DateTime? calendarDate;

    AttendanceMonth({
        this.dayKey,
        this.status,
        this.calendarDate,
    });

    AttendanceMonth copyWith({
        int? dayKey,
        int? status,
        DateTime? calendarDate,
    }) => 
        AttendanceMonth(
            dayKey: dayKey ?? this.dayKey,
            status: status ?? this.status,
            calendarDate: calendarDate ?? this.calendarDate,
        );

    factory AttendanceMonth.fromJson(Map<String, dynamic> json) => AttendanceMonth(
        dayKey: json["dayKey"],
        status: json["status"],
        calendarDate: json["calendarDate"] == null ? null : DateTime.parse(json["calendarDate"]),
    );

    Map<String, dynamic> toJson() => {
        "dayKey": dayKey,
        "status": status,
        "calendarDate": calendarDate?.toIso8601String(),
    };
}
