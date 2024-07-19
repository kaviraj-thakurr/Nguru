// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
    int? notificationCount;
    String? responseCode;
    String? responseMessage;

    NotificationModel({
        this.notificationCount,
        this.responseCode,
        this.responseMessage,
    });

    NotificationModel copyWith({
        int? notificationCount,
        String? responseCode,
        String? responseMessage,
    }) => 
        NotificationModel(
            notificationCount: notificationCount ?? this.notificationCount,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        notificationCount: json["notificationCount"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "notificationCount": notificationCount,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}
