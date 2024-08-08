// To parse this JSON data, do
//
//     final circularModel = circularModelFromJson(jsonString);

import 'dart:convert';

CircularModel circularModelFromJson(String str) => CircularModel.fromJson(json.decode(str));

String circularModelToJson(CircularModel data) => json.encode(data.toJson());

class CircularModel {
    final List<CircularList>? circularList;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    CircularModel({
        this.circularList,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    CircularModel copyWith({
        List<CircularList>? circularList,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        CircularModel(
            circularList: circularList ?? this.circularList,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory CircularModel.fromJson(Map<String, dynamic> json) => CircularModel(
        circularList: json["circularList"] == null ? [] : List<CircularList>.from(json["circularList"]!.map((x) => CircularList.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "circularList": circularList == null ? [] : List<dynamic>.from(circularList!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class CircularList {
    final int? circularId;
    final String? circularNo;
    final String? subject;
    final dynamic description;
    final int? noOfcirculars;
    final String? circularDate;
    final int? totalRecords;

    CircularList({
        this.circularId,
        this.circularNo,
        this.subject,
        this.description,
        this.noOfcirculars,
        this.circularDate,
        this.totalRecords,
    });

    CircularList copyWith({
        int? circularId,
        String? circularNo,
        String? subject,
        dynamic description,
        int? noOfcirculars,
        String? circularDate,
        int? totalRecords,
    }) => 
        CircularList(
            circularId: circularId ?? this.circularId,
            circularNo: circularNo ?? this.circularNo,
            subject: subject ?? this.subject,
            description: description ?? this.description,
            noOfcirculars: noOfcirculars ?? this.noOfcirculars,
            circularDate: circularDate ?? this.circularDate,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory CircularList.fromJson(Map<String, dynamic> json) => CircularList(
        circularId: json["circularID"],
        circularNo: json["circularNo"],
        subject: json["subject"],
        description: json["description"],
        noOfcirculars: json["noOfcirculars"],
        circularDate: json["circularDate"],
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "circularID": circularId,
        "circularNo": circularNo,
        "subject": subject,
        "description": description,
        "noOfcirculars": noOfcirculars,
        "circularDate": circularDate,
        "totalRecords": totalRecords,
    };
}

class Pagination {
    final int? pageNumber;
    final int? totalRecords;
    final int? maxPages;
    final int? visibleThreshold;

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
