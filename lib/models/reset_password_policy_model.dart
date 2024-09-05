// To parse this JSON data, do
//
//     final resetPasswordPolicyModel = resetPasswordPolicyModelFromJson(jsonString);

import 'dart:convert';

List<ResetPasswordPolicyModel> resetPasswordPolicyModelFromJson(String str) => List<ResetPasswordPolicyModel>.from(json.decode(str).map((x) => ResetPasswordPolicyModel.fromJson(x)));

String resetPasswordPolicyModelToJson(List<ResetPasswordPolicyModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResetPasswordPolicyModel {
    final String? key;
    final String? value;

    ResetPasswordPolicyModel({
        this.key,
        this.value,
    });

    ResetPasswordPolicyModel copyWith({
        String? key,
        String? value,
    }) => 
        ResetPasswordPolicyModel(
            key: key ?? this.key,
            value: value ?? this.value,
        );

    factory ResetPasswordPolicyModel.fromJson(Map<String, dynamic> json) => ResetPasswordPolicyModel(
        key: json["Key"],
        value: json["Value"],
    );

    Map<String, dynamic> toJson() => {
        "Key": key,
        "Value": value,
    };
}
