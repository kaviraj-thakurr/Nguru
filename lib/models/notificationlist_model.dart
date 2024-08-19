// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

NotificationListModel notificationListModelFromJson(String str) => NotificationListModel.fromJson(json.decode(str));

String notificationListModelToJson(NotificationListModel data) => json.encode(data.toJson());

class NotificationListModel {
    final List<NotificationList>? notificationList;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    NotificationListModel({
        this.notificationList,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    NotificationListModel copyWith({
        List<NotificationList>? notificationList,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        NotificationListModel(
            notificationList: notificationList ?? this.notificationList,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
        notificationList: json["notificationList"] == null ? [] : List<NotificationList>.from(json["notificationList"]!.map((x) => NotificationList.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "notificationList": notificationList == null ? [] : List<dynamic>.from(notificationList!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class NotificationList {
    final int? notificationId;
    final int? deviceType;
    final String? deviceToken;
    final String? notificationHeader;
    final String? notificationDetail;
    final bool? isRead;
    final int? notificationType;
    final DateTime? createdOn;
    final int? totalRecords;

    NotificationList({
        this.notificationId,
        this.deviceType,
        this.deviceToken,
        this.notificationHeader,
        this.notificationDetail,
        this.isRead,
        this.notificationType,
        this.createdOn,
        this.totalRecords,
    });

    NotificationList copyWith({
        int? notificationId,
        int? deviceType,
        String? deviceToken,
        String? notificationHeader,
        String? notificationDetail,
        bool? isRead,
        int? notificationType,
        DateTime? createdOn,
        int? totalRecords,
    }) => 
        NotificationList(
            notificationId: notificationId ?? this.notificationId,
            deviceType: deviceType ?? this.deviceType,
            deviceToken: deviceToken ?? this.deviceToken,
            notificationHeader: notificationHeader ?? this.notificationHeader,
            notificationDetail: notificationDetail ?? this.notificationDetail,
            isRead: isRead ?? this.isRead,
            notificationType: notificationType ?? this.notificationType,
            createdOn: createdOn ?? this.createdOn,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory NotificationList.fromJson(Map<String, dynamic> json) => NotificationList(
        notificationId: json["notificationID"],
        deviceType: json["deviceType"],
        deviceToken: json["deviceToken"],
        notificationHeader: json["notificationHeader"],
        notificationDetail: json["notificationDetail"],
        isRead: json["isRead"],
        notificationType: json["notificationType"],
        createdOn: json["createdOn"] == null ? null : DateTime.parse(json["createdOn"]),
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "notificationID": notificationId,
        "deviceType": deviceType,
        "deviceToken": deviceToken,
        "notificationHeader": notificationHeader,
        "notificationDetail": notificationDetail,
        "isRead": isRead,
        "notificationType": notificationType,
        "createdOn": createdOn?.toIso8601String(),
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
