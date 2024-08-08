// To parse this JSON data, do
//
//     final communicationModel = communicationModelFromJson(jsonString);

import 'dart:convert';

CommunicationModel communicationModelFromJson(String str) => CommunicationModel.fromJson(json.decode(str));

String communicationModelToJson(CommunicationModel data) => json.encode(data.toJson());

class CommunicationModel {
    final int? userId;
    final List<ListCommunicationHeaderDetail>? listCommunicationHeaderDetail;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    CommunicationModel({
        this.userId,
        this.listCommunicationHeaderDetail,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    CommunicationModel copyWith({
        int? userId,
        List<ListCommunicationHeaderDetail>? listCommunicationHeaderDetail,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        CommunicationModel(
            userId: userId ?? this.userId,
            listCommunicationHeaderDetail: listCommunicationHeaderDetail ?? this.listCommunicationHeaderDetail,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory CommunicationModel.fromJson(Map<String, dynamic> json) => CommunicationModel(
        userId: json["userId"],
        listCommunicationHeaderDetail: json["listCommunicationHeaderDetail"] == null ? [] : List<ListCommunicationHeaderDetail>.from(json["listCommunicationHeaderDetail"]!.map((x) => ListCommunicationHeaderDetail.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "listCommunicationHeaderDetail": listCommunicationHeaderDetail == null ? [] : List<dynamic>.from(listCommunicationHeaderDetail!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class ListCommunicationHeaderDetail {
    final int? userId;
    final int? appMessageId;
    final String? content;
    final String? subjectName;
    final int? createdForUserId;
    final int? createdByUserId;
    final String? entryDate;

    ListCommunicationHeaderDetail({
        this.userId,
        this.appMessageId,
        this.content,
        this.subjectName,
        this.createdForUserId,
        this.createdByUserId,
        this.entryDate,
    });

    ListCommunicationHeaderDetail copyWith({
        int? userId,
        int? appMessageId,
        String? content,
        String? subjectName,
        int? createdForUserId,
        int? createdByUserId,
        String? entryDate,
    }) => 
        ListCommunicationHeaderDetail(
            userId: userId ?? this.userId,
            appMessageId: appMessageId ?? this.appMessageId,
            content: content ?? this.content,
            subjectName: subjectName ?? this.subjectName,
            createdForUserId: createdForUserId ?? this.createdForUserId,
            createdByUserId: createdByUserId ?? this.createdByUserId,
            entryDate: entryDate ?? this.entryDate,
        );

    factory ListCommunicationHeaderDetail.fromJson(Map<String, dynamic> json) => ListCommunicationHeaderDetail(
        userId: json["userID"],
        appMessageId: json["appMessageID"],
        content: json["content"],
        subjectName: json["subjectName"],
        createdForUserId: json["createdForUserID"],
        createdByUserId: json["createdByUserId"],
        entryDate: json["entryDate"],
    );

    Map<String, dynamic> toJson() => {
        "userID": userId,
        "appMessageID": appMessageId,
        "content": content,
        "subjectName": subjectName,
        "createdForUserID": createdForUserId,
        "createdByUserId": createdByUserId,
        "entryDate": entryDate,
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
