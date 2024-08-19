// To parse this JSON data, do
//
//     final attendenceModel = attendenceModelFromJson(jsonString);

import 'dart:convert';

AttendenceModel attendenceModelFromJson(String str) => AttendenceModel.fromJson(json.decode(str));

String attendenceModelToJson(AttendenceModel data) => json.encode(data.toJson());

class AttendenceModel {
    List<AttendanceCumulativeModel>? attendanceCumulativeModel;
    String? responseCode;
    String? responseMessage;

    AttendenceModel({
        this.attendanceCumulativeModel,
        this.responseCode,
        this.responseMessage,
    });

    AttendenceModel copyWith({
        List<AttendanceCumulativeModel>? attendanceCumulativeModel,
        String? responseCode,
        String? responseMessage,
    }) => 
        AttendenceModel(
            attendanceCumulativeModel: attendanceCumulativeModel ?? this.attendanceCumulativeModel,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory AttendenceModel.fromJson(Map<String, dynamic> json) => AttendenceModel(
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
    String? monthName;
    String? hoidays;
    String? presentDay;
    String? absentDay;
    String? leaveDay;
    String? workingDays;
    String? overAllPercentage;
    String? monthWisePercentage;

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
