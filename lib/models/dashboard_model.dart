// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) => DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
    final int? studentId;
    final String? enrollmentNumber;
    final String? admissionNumber;
    final int? notificationCount;
    final String? studentName;
    final String? studentPicture;
    final String? qualification;
    final String? section;
    final List<DashboardList>? dashboardList;
    final String? responseCode;
    final String? responseMessage;

    DashboardModel({
        this.studentId,
        this.enrollmentNumber,
        this.admissionNumber,
        this.notificationCount,
        this.studentName,
        this.studentPicture,
        this.qualification,
        this.section,
        this.dashboardList,
        this.responseCode,
        this.responseMessage,
    });

    DashboardModel copyWith({
        int? studentId,
        String? enrollmentNumber,
        String? admissionNumber,
        int? notificationCount,
        String? studentName,
        String? studentPicture,
        String? qualification,
        String? section,
        List<DashboardList>? dashboardList,
        String? responseCode,
        String? responseMessage,
    }) => 
        DashboardModel(
            studentId: studentId ?? this.studentId,
            enrollmentNumber: enrollmentNumber ?? this.enrollmentNumber,
            admissionNumber: admissionNumber ?? this.admissionNumber,
            notificationCount: notificationCount ?? this.notificationCount,
            studentName: studentName ?? this.studentName,
            studentPicture: studentPicture ?? this.studentPicture,
            qualification: qualification ?? this.qualification,
            section: section ?? this.section,
            dashboardList: dashboardList ?? this.dashboardList,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        studentId: json["studentID"],
        enrollmentNumber: json["enrollmentNumber"],
        admissionNumber: json["admissionNumber"],
        notificationCount: json["notificationCount"],
        studentName: json["studentName"],
        studentPicture: json["studentPicture"],
        qualification: json["qualification"],
        section: json["section"],
        dashboardList: json["dashboardList"] == null ? [] : List<DashboardList>.from(json["dashboardList"]!.map((x) => DashboardList.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "studentID": studentId,
        "enrollmentNumber": enrollmentNumber,
        "admissionNumber": admissionNumber,
        "notificationCount": notificationCount,
        "studentName": studentName,
        "studentPicture": studentPicture,
        "qualification": qualification,
        "section": section,
        "dashboardList": dashboardList == null ? [] : List<dynamic>.from(dashboardList!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class DashboardList {
    final String? dashboardItem;
    final String? dashboardValue;

    DashboardList({
        this.dashboardItem,
        this.dashboardValue,
    });

    DashboardList copyWith({
        String? dashboardItem,
        String? dashboardValue,
    }) => 
        DashboardList(
            dashboardItem: dashboardItem ?? this.dashboardItem,
            dashboardValue: dashboardValue ?? this.dashboardValue,
        );

    factory DashboardList.fromJson(Map<String, dynamic> json) => DashboardList(
        dashboardItem: json["dashboardItem"],
        dashboardValue: json["dashboardValue"],
    );

    Map<String, dynamic> toJson() => {
        "dashboardItem": dashboardItem,
        "dashboardValue": dashboardValue,
    };
}
