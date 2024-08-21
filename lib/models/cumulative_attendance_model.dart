// To parse this JSON data, do
//
//     final cumulativeAttendanceModel = cumulativeAttendanceModelFromJson(jsonString);

import 'dart:convert';

CumulativeAttendanceModel cumulativeAttendanceModelFromJson(String str) => CumulativeAttendanceModel.fromJson(json.decode(str));

String cumulativeAttendanceModelToJson(CumulativeAttendanceModel data) => json.encode(data.toJson());

class CumulativeAttendanceModel {
    final List<AttendanceCumulativeModel>? attendanceCumulativeModel;
    final String? responseCode;
    final String? responseMessage;

    CumulativeAttendanceModel({
        this.attendanceCumulativeModel,
        this.responseCode,
        this.responseMessage,
    });

    CumulativeAttendanceModel copyWith({
        List<AttendanceCumulativeModel>? attendanceCumulativeModel,
        String? responseCode,
        String? responseMessage,
    }) => 
        CumulativeAttendanceModel(
            attendanceCumulativeModel: attendanceCumulativeModel ?? this.attendanceCumulativeModel,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory CumulativeAttendanceModel.fromJson(Map<String, dynamic> json) => CumulativeAttendanceModel(
        attendanceCumulativeModel: json["attendanceCumulativeModel"] == null ? [] : List<AttendanceCumulativeModel>.from(json["attendanceCumulativeModel"]!.map((x) => AttendanceCumulativeModel.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "attendanceCumulativeModel": attendanceCumulativeModel == null ? [] : List<dynamic>.from(attendanceCumulativeModel!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class AttendanceCumulativeModel {
    final String? monthName;
    final String? hoidays;
    final String? presentDay;
    final String? absentDay;
    final String? leaveDay;
    final String? workingDays;
    final String? overAllPercentage;
    final String? monthWisePercentage;

    AttendanceCumulativeModel({
        this.monthName,
        this.hoidays,
        this.presentDay,
        this.absentDay,
        this.leaveDay,
        this.workingDays,
        this.overAllPercentage,
        this.monthWisePercentage,
    });

    AttendanceCumulativeModel copyWith({
        String? monthName,
        String? hoidays,
        String? presentDay,
        String? absentDay,
        String? leaveDay,
        String? workingDays,
        String? overAllPercentage,
        String? monthWisePercentage,
    }) => 
        AttendanceCumulativeModel(
            monthName: monthName ?? this.monthName,
            hoidays: hoidays ?? this.hoidays,
            presentDay: presentDay ?? this.presentDay,
            absentDay: absentDay ?? this.absentDay,
            leaveDay: leaveDay ?? this.leaveDay,
            workingDays: workingDays ?? this.workingDays,
            overAllPercentage: overAllPercentage ?? this.overAllPercentage,
            monthWisePercentage: monthWisePercentage ?? this.monthWisePercentage,
        );

    factory AttendanceCumulativeModel.fromJson(Map<String, dynamic> json) => AttendanceCumulativeModel(
        monthName: json["monthName"],
        hoidays: json["hoidays"],
        presentDay: json["presentDay"],
        absentDay: json["absentDay"],
        leaveDay: json["leaveDay"],
        workingDays: json["workingDays"],
        overAllPercentage: json["overAllPercentage"],
        monthWisePercentage: json["monthWisePercentage"],
    );

    Map<String, dynamic> toJson() => {
        "monthName": monthName,
        "hoidays": hoidays,
        "presentDay": presentDay,
        "absentDay": absentDay,
        "leaveDay": leaveDay,
        "workingDays": workingDays,
        "overAllPercentage": overAllPercentage,
        "monthWisePercentage": monthWisePercentage,
    };
}
