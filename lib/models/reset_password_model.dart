// To parse this JSON data, do
//
//     final resetPasswordModel = resetPasswordModelFromJson(jsonString);

import 'dart:convert';

ResetPasswordModel resetPasswordModelFromJson(String str) => ResetPasswordModel.fromJson(json.decode(str));

String resetPasswordModelToJson(ResetPasswordModel data) => json.encode(data.toJson());

class ResetPasswordModel {
    dynamic oldPassword;
    dynamic newPassword;
    int? status;
    String? responseCode;
    String? responseMessage;
    int? userId;
    int? schoolId;
    int? studentId;
    int? sessionId;
    dynamic schoolUrl;
    int? pageNumber;

    ResetPasswordModel({
        this.oldPassword,
        this.newPassword,
        this.status,
        this.responseCode,
        this.responseMessage,
        this.userId,
        this.schoolId,
        this.studentId,
        this.sessionId,
        this.schoolUrl,
        this.pageNumber,
    });

    ResetPasswordModel copyWith({
        dynamic oldPassword,
        dynamic newPassword,
        int? status,
        String? responseCode,
        String? responseMessage,
        int? userId,
        int? schoolId,
        int? studentId,
        int? sessionId,
        dynamic schoolUrl,
        int? pageNumber,
    }) => 
        ResetPasswordModel(
            oldPassword: oldPassword ?? this.oldPassword,
            newPassword: newPassword ?? this.newPassword,
            status: status ?? this.status,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
            userId: userId ?? this.userId,
            schoolId: schoolId ?? this.schoolId,
            studentId: studentId ?? this.studentId,
            sessionId: sessionId ?? this.sessionId,
            schoolUrl: schoolUrl ?? this.schoolUrl,
            pageNumber: pageNumber ?? this.pageNumber,
        );

    factory ResetPasswordModel.fromJson(Map<String, dynamic> json) => ResetPasswordModel(
        oldPassword: json["oldPassword"],
        newPassword: json["newPassword"],
        status: json["status"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
        userId: json["userID"],
        schoolId: json["schoolID"],
        studentId: json["studentID"],
        sessionId: json["sessionID"],
        schoolUrl: json["schoolURL"],
        pageNumber: json["pageNumber"],
    );

    Map<String, dynamic> toJson() => {
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "status": status,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
        "userID": userId,
        "schoolID": schoolId,
        "studentID": studentId,
        "sessionID": sessionId,
        "schoolURL": schoolUrl,
        "pageNumber": pageNumber,
    };
}
