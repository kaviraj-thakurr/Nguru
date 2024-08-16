// To parse this JSON data, do
//
//     final activityModel = activityModelFromJson(jsonString);

import 'dart:convert';

ActivityModel activityModelFromJson(String str) => ActivityModel.fromJson(json.decode(str));

String activityModelToJson(ActivityModel data) => json.encode(data.toJson());

class ActivityModel {
    final List<ActivityList>? activityList;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    ActivityModel({
        this.activityList,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    ActivityModel copyWith({
        List<ActivityList>? activityList,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        ActivityModel(
            activityList: activityList ?? this.activityList,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        activityList: json["activityList"] == null ? [] : List<ActivityList>.from(json["activityList"]!.map((x) => ActivityList.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "activityList": activityList == null ? [] : List<dynamic>.from(activityList!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class ActivityList {
    final int? activityId;
    final String? studentName;
    final String? eventName;
    final String? position;
    final double? points;
    final String? eventDate;
    final String? eventLevel;
    final String? address;
    final String? activityName;
    final String? activityDescription;
    final int? totalRecords;

    ActivityList({
        this.activityId,
        this.studentName,
        this.eventName,
        this.position,
        this.points,
        this.eventDate,
        this.eventLevel,
        this.address,
        this.activityName,
        this.activityDescription,
        this.totalRecords,
    });

    ActivityList copyWith({
        int? activityId,
        String? studentName,
        String? eventName,
        String? position,
        double? points,
        String? eventDate,
        String? eventLevel,
        String? address,
        String? activityName,
        String? activityDescription,
        int? totalRecords,
    }) => 
        ActivityList(
            activityId: activityId ?? this.activityId,
            studentName: studentName ?? this.studentName,
            eventName: eventName ?? this.eventName,
            position: position ?? this.position,
            points: points ?? this.points,
            eventDate: eventDate ?? this.eventDate,
            eventLevel: eventLevel ?? this.eventLevel,
            address: address ?? this.address,
            activityName: activityName ?? this.activityName,
            activityDescription: activityDescription ?? this.activityDescription,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory ActivityList.fromJson(Map<String, dynamic> json) => ActivityList(
        activityId: json["activityID"],
        studentName: json["studentName"],
        eventName: json["eventName"],
        position: json["position"],
        points: json["points"],
        eventDate: json["eventDate"],
        eventLevel: json["eventLevel"],
        address: json["address"],
        activityName: json["activityName"],
        activityDescription: json["activityDescription"],
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "activityID": activityId,
        "studentName": studentName,
        "eventName": eventName,
        "position": position,
        "points": points,
        "eventDate": eventDate,
        "eventLevel": eventLevel,
        "address": address,
        "activityName": activityName,
        "activityDescription": activityDescription,
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
