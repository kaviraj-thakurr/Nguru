// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    final String? schoolPhoto;
    final int? userId;
    final int? schoolId;
    final dynamic schoolLogo;
    final int? changePwdCount;
    final StudentProfile? studentProfile;
    final String? responseCode;
    final String? responseMessage;

    LoginModel({
        this.schoolPhoto,
        this.userId,
        this.schoolId,
        this.schoolLogo,
        this.changePwdCount,
        this.studentProfile,
        this.responseCode,
        this.responseMessage,
    });

    LoginModel copyWith({
        String? schoolPhoto,
        int? userId,
        int? schoolId,
        dynamic schoolLogo,
        int? changePwdCount,
        StudentProfile? studentProfile,
        String? responseCode,
        String? responseMessage,
    }) => 
        LoginModel(
            schoolPhoto: schoolPhoto ?? this.schoolPhoto,
            userId: userId ?? this.userId,
            schoolId: schoolId ?? this.schoolId,
            schoolLogo: schoolLogo ?? this.schoolLogo,
            changePwdCount: changePwdCount ?? this.changePwdCount,
            studentProfile: studentProfile ?? this.studentProfile,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        schoolPhoto: json["schoolPhoto"],
        userId: json["userID"],
        schoolId: json["schoolID"],
        schoolLogo: json["schoolLogo"],
        changePwdCount: json["changePwdCount"],
        studentProfile: json["studentProfile"] == null ? null : StudentProfile.fromJson(json["studentProfile"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "schoolPhoto": schoolPhoto,
        "userID": userId,
        "schoolID": schoolId,
        "schoolLogo": schoolLogo,
        "changePwdCount": changePwdCount,
        "studentProfile": studentProfile?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class StudentProfile {
    final int? studentId;
    final String? enrollmentNumber;
    final String? studentName;
    final String? studentPicture;
    final String? standard;
    final String? section;
    final String? admissionNo;
    final String? dob;
    final String? studentMobileNumber;
    final String? address;
    final int? sessionId;
    final DateTime? sessionStartDate;
    final DateTime? sessionEndDate;
    final String? admissionNumber;
    final int? notificationCount;
    final int? notificationStatus;
    final int? classTeacherId;
    final String? classTeacherName;
    final String? classTeacherPhoto;

    StudentProfile({
        this.studentId,
        this.enrollmentNumber,
        this.studentName,
        this.studentPicture,
        this.standard,
        this.section,
        this.admissionNo,
        this.dob,
        this.studentMobileNumber,
        this.address,
        this.sessionId,
        this.sessionStartDate,
        this.sessionEndDate,
        this.admissionNumber,
        this.notificationCount,
        this.notificationStatus,
        this.classTeacherId,
        this.classTeacherName,
        this.classTeacherPhoto,
    });

    StudentProfile copyWith({
        int? studentId,
        String? enrollmentNumber,
        String? studentName,
        String? studentPicture,
        String? standard,
        String? section,
        String? admissionNo,
        String? dob,
        String? studentMobileNumber,
        String? address,
        int? sessionId,
        DateTime? sessionStartDate,
        DateTime? sessionEndDate,
        String? admissionNumber,
        int? notificationCount,
        int? notificationStatus,
        int? classTeacherId,
        String? classTeacherName,
        String? classTeacherPhoto,
    }) => 
        StudentProfile(
            studentId: studentId ?? this.studentId,
            enrollmentNumber: enrollmentNumber ?? this.enrollmentNumber,
            studentName: studentName ?? this.studentName,
            studentPicture: studentPicture ?? this.studentPicture,
            standard: standard ?? this.standard,
            section: section ?? this.section,
            admissionNo: admissionNo ?? this.admissionNo,
            dob: dob ?? this.dob,
            studentMobileNumber: studentMobileNumber ?? this.studentMobileNumber,
            address: address ?? this.address,
            sessionId: sessionId ?? this.sessionId,
            sessionStartDate: sessionStartDate ?? this.sessionStartDate,
            sessionEndDate: sessionEndDate ?? this.sessionEndDate,
            admissionNumber: admissionNumber ?? this.admissionNumber,
            notificationCount: notificationCount ?? this.notificationCount,
            notificationStatus: notificationStatus ?? this.notificationStatus,
            classTeacherId: classTeacherId ?? this.classTeacherId,
            classTeacherName: classTeacherName ?? this.classTeacherName,
            classTeacherPhoto: classTeacherPhoto ?? this.classTeacherPhoto,
        );

    factory StudentProfile.fromJson(Map<String, dynamic> json) => StudentProfile(
        studentId: json["studentID"],
        enrollmentNumber: json["enrollmentNumber"],
        studentName: json["studentName"],
        studentPicture: json["studentPicture"],
        standard: json["standard"],
        section: json["section"],
        admissionNo: json["admissionNO"],
        dob: json["dob"],
        studentMobileNumber: json["studentMobileNumber"],
        address: json["address"],
        sessionId: json["sessionID"],
        sessionStartDate: json["sessionStartDate"] == null ? null : DateTime.parse(json["sessionStartDate"]),
        sessionEndDate: json["sessionEndDate"] == null ? null : DateTime.parse(json["sessionEndDate"]),
        admissionNumber: json["admissionNumber"],
        notificationCount: json["notificationCount"],
        notificationStatus: json["notificationStatus"],
        classTeacherId: json["classTeacherId"],
        classTeacherName: json["classTeacherName"],
        classTeacherPhoto: json["classTeacherPhoto"],
    );

    Map<String, dynamic> toJson() => {
        "studentID": studentId,
        "enrollmentNumber": enrollmentNumber,
        "studentName": studentName,
        "studentPicture": studentPicture,
        "standard": standard,
        "section": section,
        "admissionNO": admissionNo,
        "dob": dob,
        "studentMobileNumber": studentMobileNumber,
        "address": address,
        "sessionID": sessionId,
        "sessionStartDate": sessionStartDate?.toIso8601String(),
        "sessionEndDate": sessionEndDate?.toIso8601String(),
        "admissionNumber": admissionNumber,
        "notificationCount": notificationCount,
        "notificationStatus": notificationStatus,
        "classTeacherId": classTeacherId,
        "classTeacherName": classTeacherName,
        "classTeacherPhoto": classTeacherPhoto,
    };
}
