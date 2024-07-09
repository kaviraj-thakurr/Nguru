// To parse this JSON data, do
//
//     final addSchool = addSchoolFromJson(jsonString);

import 'dart:convert';

AddSchoolModel addSchoolFromJson(String str) =>
    AddSchoolModel.fromJson(json.decode(str));

String addSchoolToJson(AddSchoolModel data) => json.encode(data.toJson());

class AddSchoolModel {
  String? schoolPhoto;
  int? schoolId;
  String? schoolName;
  String? schoolCode;
  String? address;
  String? mobileNo;
  String? pincode;
  dynamic schoolLogo;
  String? responseCode;
  String? responseMessage;

  AddSchoolModel({
    this.schoolPhoto,
    this.schoolId,
    this.schoolName,
    this.schoolCode,
    this.address,
    this.mobileNo,
    this.pincode,
    this.schoolLogo,
    this.responseCode,
    this.responseMessage,
  });

  factory AddSchoolModel.fromJson(Map<String, dynamic> json) => AddSchoolModel(
        schoolPhoto: json["schoolPhoto"],
        schoolId: json["schoolID"],
        schoolName: json["schoolName"],
        schoolCode: json["schoolCode"],
        address: json["address"],
        mobileNo: json["mobileNo"],
        pincode: json["pincode"],
        schoolLogo: json["schoolLogo"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
      );

  Map<String, dynamic> toJson() => {
        "schoolPhoto": schoolPhoto,
        "schoolID": schoolId,
        "schoolName": schoolName,
        "schoolCode": schoolCode,
        "address": address,
        "mobileNo": mobileNo,
        "pincode": pincode,
        "schoolLogo": schoolLogo,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
      };
}
