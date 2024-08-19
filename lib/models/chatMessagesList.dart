// To parse this JSON data, do
//
//     final listCommunicationModel = listCommunicationModelFromJson(jsonString);

import 'dart:convert';

ListCommunicationModel listCommunicationModelFromJson(String str) => ListCommunicationModel.fromJson(json.decode(str));

String listCommunicationModelToJson(ListCommunicationModel data) => json.encode(data.toJson());

class ListCommunicationModel {
    final List<ListcommunicationMsgDetail>? listcommunicationMsgDetail;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    ListCommunicationModel({
        this.listcommunicationMsgDetail,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    ListCommunicationModel copyWith({
        List<ListcommunicationMsgDetail>? listcommunicationMsgDetail,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        ListCommunicationModel(
            listcommunicationMsgDetail: listcommunicationMsgDetail ?? this.listcommunicationMsgDetail,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory ListCommunicationModel.fromJson(Map<String, dynamic> json) => ListCommunicationModel(
        listcommunicationMsgDetail: json["listcommunicationMsgDetail"] == null ? [] : List<ListcommunicationMsgDetail>.from(json["listcommunicationMsgDetail"]!.map((x) => ListcommunicationMsgDetail.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "listcommunicationMsgDetail": listcommunicationMsgDetail == null ? [] : List<dynamic>.from(listcommunicationMsgDetail!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class ListcommunicationMsgDetail {
    final String? content;
    final int? createdByUserId;
    final int? createdForUserId;
    final String? createdDate;
    final int? totalRecords;

    ListcommunicationMsgDetail({
        this.content,
        this.createdByUserId,
        this.createdForUserId,
        this.createdDate,
        this.totalRecords,
    });

    ListcommunicationMsgDetail copyWith({
        String? content,
        int? createdByUserId,
        int? createdForUserId,
        String? createdDate,
        int? totalRecords,
    }) => 
        ListcommunicationMsgDetail(
            content: content ?? this.content,
            createdByUserId: createdByUserId ?? this.createdByUserId,
            createdForUserId: createdForUserId ?? this.createdForUserId,
            createdDate: createdDate ?? this.createdDate,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory ListcommunicationMsgDetail.fromJson(Map<String, dynamic> json) => ListcommunicationMsgDetail(
        content: json["content"],
        createdByUserId: json["createdByUserId"],
        createdForUserId: json["createdForUserId"],
        createdDate: json["createdDate"],
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "content": content,
        "createdByUserId": createdByUserId,
        "createdForUserId": createdForUserId,
        "createdDate": createdDate,
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
