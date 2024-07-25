// To parse this JSON data, do
//
//     final disciplineModel = disciplineModelFromJson(jsonString);

import 'dart:convert';

DisciplineModel disciplineModelFromJson(String str) => DisciplineModel.fromJson(json.decode(str));

String disciplineModelToJson(DisciplineModel data) => json.encode(data.toJson());

class DisciplineModel {
    List<DisciplineList>? disciplineList;
    Pagination? pagination;
    String? responseCode;
    String? responseMessage;

    DisciplineModel({
        this.disciplineList,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    DisciplineModel copyWith({
        List<DisciplineList>? disciplineList,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        DisciplineModel(
            disciplineList: disciplineList ?? this.disciplineList,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory DisciplineModel.fromJson(Map<String, dynamic> json) => DisciplineModel(
        disciplineList: json["disciplineList"] == null ? [] : List<DisciplineList>.from(json["disciplineList"]!.map((x) => DisciplineList.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "disciplineList": disciplineList == null ? [] : List<dynamic>.from(disciplineList!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class DisciplineList {
    String? actionDate;
    String? points;
    String? reason;
    String? teacherName;
    String? cardtype;

    DisciplineList({
        this.actionDate,
        this.points,
        this.reason,
        this.teacherName,
        this.cardtype,
    });

    DisciplineList copyWith({
        String? actionDate,
        String? points,
        String? reason,
        String? teacherName,
        String? cardtype,
    }) => 
        DisciplineList(
            actionDate: actionDate ?? this.actionDate,
            points: points ?? this.points,
            reason: reason ?? this.reason,
            teacherName: teacherName ?? this.teacherName,
            cardtype: cardtype ?? this.cardtype,
        );

    factory DisciplineList.fromJson(Map<String, dynamic> json) => DisciplineList(
        actionDate: json["actionDate"],
        points: json["points"],
        reason: json["reason"],
        teacherName: json["teacherName"],
        cardtype: json["cardtype"],
    );

    Map<String, dynamic> toJson() => {
        "actionDate": actionDate,
        "points": points,
        "reason": reason,
        "teacherName": teacherName,
        "cardtype": cardtype,
    };
}

class Pagination {
    int? pageNumber;
    int? totalRecords;
    int? maxPages;
    int? visibleThreshold;

    Pagination({
        this.pageNumber,
        this.totalRecords,
        this.maxPages,
        this.visibleThreshold,
    });

    Pagination copyWith({
        int? pageNumber,
        int? totalRecords,
        int? maxPages,
        int? visibleThreshold,
    }) => 
        Pagination(
            pageNumber: pageNumber ?? this.pageNumber,
            totalRecords: totalRecords ?? this.totalRecords,
            maxPages: maxPages ?? this.maxPages,
            visibleThreshold: visibleThreshold ?? this.visibleThreshold,
        );

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        pageNumber: json["pageNumber"],
        totalRecords: json["totalRecords"],
        maxPages: json["maxPages"],
        visibleThreshold: json["visibleThreshold"],
    );

    Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "totalRecords": totalRecords,
        "maxPages": maxPages,
        "visibleThreshold": visibleThreshold,
    };
}
