// To parse this JSON data, do
//
//     final forgetPassWordModel = forgetPassWordModelFromJson(jsonString);

import 'dart:convert';

ForgetPassWordModel forgetPassWordModelFromJson(String str) => ForgetPassWordModel.fromJson(json.decode(str));

String forgetPassWordModelToJson(ForgetPassWordModel data) => json.encode(data.toJson());

class ForgetPassWordModel {
    String? responseCode;
    String? responseMessage;

    ForgetPassWordModel({
        this.responseCode,
        this.responseMessage,
    });

    ForgetPassWordModel copyWith({
        String? responseCode,
        String? responseMessage,
    }) => 
        ForgetPassWordModel(
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory ForgetPassWordModel.fromJson(Map<String, dynamic> json) => ForgetPassWordModel(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}
