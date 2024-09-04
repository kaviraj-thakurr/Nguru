// To parse this JSON data, do
//
//     final changeSessionModel = changeSessionModelFromJson(jsonString);

import 'dart:convert';

List<ChangeSessionModel> changeSessionModelFromJson(String str) => List<ChangeSessionModel>.from(json.decode(str).map((x) => ChangeSessionModel.fromJson(x)));

String changeSessionModelToJson(List<ChangeSessionModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChangeSessionModel {
    final int? key;
    final String? value;

    ChangeSessionModel({
        this.key,
        this.value,
    });

    ChangeSessionModel copyWith({
        int? key,
        String? value,
    }) => 
        ChangeSessionModel(
            key: key ?? this.key,
            value: value ?? this.value,
        );

    factory ChangeSessionModel.fromJson(Map<String, dynamic> json) => ChangeSessionModel(
        key: json["Key"],
        value: json["Value"],
    );

    Map<String, dynamic> toJson() => {
        "Key": key,
        "Value": value,
    };
}
