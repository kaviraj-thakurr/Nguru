// To parse this JSON data, do
//
//     final disciplineModel = disciplineModelFromJson(jsonString);

import 'dart:convert';

DisciplineModel disciplineModelFromJson(String str) => DisciplineModel.fromJson(json.decode(str));

String disciplineModelToJson(DisciplineModel data) => json.encode(data.toJson());

class DisciplineModel {
    final List<DisciplineList>? disciplineList;
    final String? responseCode;
    final String? responseMessage;

    DisciplineModel({
        this.disciplineList,
        this.responseCode,
        this.responseMessage,
    });

    DisciplineModel copyWith({
        List<DisciplineList>? disciplineList,
        String? responseCode,
        String? responseMessage,
    }) => 
        DisciplineModel(
            disciplineList: disciplineList ?? this.disciplineList,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory DisciplineModel.fromJson(Map<String, dynamic> json) => DisciplineModel(
        disciplineList: json["disciplineList"] == null ? [] : List<DisciplineList>.from(json["disciplineList"]!.map((x) => DisciplineList.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "disciplineList": disciplineList == null ? [] : List<dynamic>.from(disciplineList!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class DisciplineList {
    final String? actionDate;
    final String? points;
    final String? pointsType;
    final String? reason;
    final String? teacherName;
    final String? cardtype;
    final String? totalNegative;
    final String? totalPositive;

    DisciplineList({
        this.actionDate,
        this.points,
        this.pointsType,
        this.reason,
        this.teacherName,
        this.cardtype,
        this.totalNegative,
        this.totalPositive,
    });

    DisciplineList copyWith({
        String? actionDate,
        String? points,
        String? pointsType,
        String? reason,
        String? teacherName,
        String? cardtype,
        String? totalNegative,
        String? totalPositive,
    }) => 
        DisciplineList(
            actionDate: actionDate ?? this.actionDate,
            points: points ?? this.points,
            pointsType: pointsType ?? this.pointsType,
            reason: reason ?? this.reason,
            teacherName: teacherName ?? this.teacherName,
            cardtype: cardtype ?? this.cardtype,
            totalNegative: totalNegative ?? this.totalNegative,
            totalPositive: totalPositive ?? this.totalPositive,
        );

    factory DisciplineList.fromJson(Map<String, dynamic> json) => DisciplineList(
        actionDate: json["actionDate"],
        points: json["points"],
        pointsType: json["pointsType"],
        reason: json["reason"],
        teacherName: json["teacherName"],
        cardtype: json["cardtype"],
        totalNegative: json["TotalNegative"],
        totalPositive: json["TotalPositive"],
    );

    Map<String, dynamic> toJson() => {
        "actionDate": actionDate,
        "points": points,
        "pointsType": pointsType,
        "reason": reason,
        "teacherName": teacherName,
        "cardtype": cardtype,
        "TotalNegative": totalNegative,
        "TotalPositive": totalPositive,
    };
}
