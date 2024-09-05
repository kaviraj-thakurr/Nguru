// To parse this JSON data, do
//
//     final scheduleModel = scheduleModelFromJson(jsonString);

import 'dart:convert';

ScheduleModel scheduleModelFromJson(String str) => ScheduleModel.fromJson(json.decode(str));

String scheduleModelToJson(ScheduleModel data) => json.encode(data.toJson());

class ScheduleModel {
    final List<Examinationschedulemodel>? examinationschedulemodel;
    final String? responseCode;
    final String? responseMessage;

    ScheduleModel({
        this.examinationschedulemodel,
        this.responseCode,
        this.responseMessage,
    });

    ScheduleModel copyWith({
        List<Examinationschedulemodel>? examinationschedulemodel,
        String? responseCode,
        String? responseMessage,
    }) => 
        ScheduleModel(
            examinationschedulemodel: examinationschedulemodel ?? this.examinationschedulemodel,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory ScheduleModel.fromJson(Map<String, dynamic> json) => ScheduleModel(
        examinationschedulemodel: json["examinationschedulemodel"] == null ? [] : List<Examinationschedulemodel>.from(json["examinationschedulemodel"]!.map((x) => Examinationschedulemodel.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "examinationschedulemodel": examinationschedulemodel == null ? [] : List<dynamic>.from(examinationschedulemodel!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class Examinationschedulemodel {
    final String? examName;
    final String? subjectName;
    final String? examdate;

    Examinationschedulemodel({
        this.examName,
        this.subjectName,
        this.examdate,
    });

    Examinationschedulemodel copyWith({
        String? examName,
        String? subjectName,
        String? examdate,
    }) => 
        Examinationschedulemodel(
            examName: examName ?? this.examName,
            subjectName: subjectName ?? this.subjectName,
            examdate: examdate ?? this.examdate,
        );

    factory Examinationschedulemodel.fromJson(Map<String, dynamic> json) => Examinationschedulemodel(
        examName: json["ExamName"],
        subjectName: json["SubjectName"],
        examdate: json["Examdate"],
    );

    Map<String, dynamic> toJson() => {
        "ExamName": examName,
        "SubjectName": subjectName,
        "Examdate": examdate,
    };
}
