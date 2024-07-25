import 'dart:convert';

PushNotificationModel pushNotificationModelFromJson(String str) => PushNotificationModel.fromJson(json.decode(str));

String pushNotificationModelToJson(PushNotificationModel data) => json.encode(data.toJson());

class PushNotificationModel {
    int? deviceType;
    int? isNotification;
    String? responseCode;
    String? responseMessage;

    PushNotificationModel({
        this.deviceType,
        this.isNotification,
        this.responseCode,
        this.responseMessage,
    });

    PushNotificationModel copyWith({
        int? deviceType,
        int? isNotification,
        String? responseCode,
        String? responseMessage,
    }) => 
        PushNotificationModel(
            deviceType: deviceType ?? this.deviceType,
            isNotification: isNotification ?? this.isNotification,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory PushNotificationModel.fromJson(Map<String, dynamic> json) => PushNotificationModel(
        deviceType: json["deviceType"],
        isNotification: json["isNotification"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "deviceType": deviceType,
        "isNotification": isNotification,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}
