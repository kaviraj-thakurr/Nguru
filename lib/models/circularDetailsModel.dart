// To parse this JSON data, do
//
//     final circularDetailModel = circularDetailModelFromJson(jsonString);

import 'dart:convert';

CircularDetailModel circularDetailModelFromJson(String str) => CircularDetailModel.fromJson(json.decode(str));

String circularDetailModelToJson(CircularDetailModel data) => json.encode(data.toJson());

class CircularDetailModel {
    final List<CircularList>? circularList;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    CircularDetailModel({
        this.circularList,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    CircularDetailModel copyWith({
        List<CircularList>? circularList,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        CircularDetailModel(
            circularList: circularList ?? this.circularList,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory CircularDetailModel.fromJson(Map<String, dynamic> json) => CircularDetailModel(
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
    final String? contentData;
    final String? fileName;
    final String? fileType;
    final String? subject;
    final String? description;
    final String? circularDate;
    final int? totalRecords;

    CircularList({
        this.circularId,
        this.circularNo,
        this.contentData,
        this.fileName,
        this.fileType,
        this.subject,
        this.description,
        this.circularDate,
        this.totalRecords,
    });

    CircularList copyWith({
        int? circularId,
        String? circularNo,
        String? contentData,
        String? fileName,
        String? fileType,
        String? subject,
        String? description,
        String? circularDate,
        int? totalRecords,
    }) => 
        CircularList(
            circularId: circularId ?? this.circularId,
            circularNo: circularNo ?? this.circularNo,
            contentData: contentData ?? this.contentData,
            fileName: fileName ?? this.fileName,
            fileType: fileType ?? this.fileType,
            subject: subject ?? this.subject,
            description: description ?? this.description,
            circularDate: circularDate ?? this.circularDate,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory CircularList.fromJson(Map<String, dynamic> json) => CircularList(
        circularId: json["circularID"],
        circularNo: json["circularNo"],
        contentData: json["contentData"],
        fileName: json["fileName"],
        fileType: json["fileType"],
        subject: json["subject"],
        description: json["description"],
        circularDate: json["circularDate"],
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "circularID": circularId,
        "circularNo": circularNo,
        "contentData": contentData,
        "fileName": fileName,
        "fileType": fileType,
        "subject": subject,
        "description": description,
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
