// To parse this JSON data, do
//
//     final changeSiblingsModel = changeSiblingsModelFromJson(jsonString);

import 'dart:convert';

ChangeSiblingsModel changeSiblingsModelFromJson(String str) => ChangeSiblingsModel.fromJson(json.decode(str));

String changeSiblingsModelToJson(ChangeSiblingsModel data) => json.encode(data.toJson());

class ChangeSiblingsModel {
    final List<SiblingList>? siblingList;
    final String? responseCode;
    final String? responseMessage;

    ChangeSiblingsModel({
        this.siblingList,
        this.responseCode,
        this.responseMessage,
    });

    ChangeSiblingsModel copyWith({
        List<SiblingList>? siblingList,
        String? responseCode,
        String? responseMessage,
    }) => 
        ChangeSiblingsModel(
            siblingList: siblingList ?? this.siblingList,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory ChangeSiblingsModel.fromJson(Map<String, dynamic> json) => ChangeSiblingsModel(
        siblingList: json["siblingList"] == null ? [] : List<SiblingList>.from(json["siblingList"]!.map((x) => SiblingList.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "siblingList": siblingList == null ? [] : List<dynamic>.from(siblingList!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class SiblingList {
    final int? studentId;
    final String? studentName;
    final String? studentPicture;
    final int? classTeacherId;
    final String? classTeacherName;
    final dynamic classTeacherPhoto;

    SiblingList({
        this.studentId,
        this.studentName,
        this.studentPicture,
        this.classTeacherId,
        this.classTeacherName,
        this.classTeacherPhoto,
    });

    SiblingList copyWith({
        int? studentId,
        String? studentName,
        String? studentPicture,
        int? classTeacherId,
        String? classTeacherName,
        dynamic classTeacherPhoto,
    }) => 
        SiblingList(
            studentId: studentId ?? this.studentId,
            studentName: studentName ?? this.studentName,
            studentPicture: studentPicture ?? this.studentPicture,
            classTeacherId: classTeacherId ?? this.classTeacherId,
            classTeacherName: classTeacherName ?? this.classTeacherName,
            classTeacherPhoto: classTeacherPhoto ?? this.classTeacherPhoto,
        );

    factory SiblingList.fromJson(Map<String, dynamic> json) => SiblingList(
        studentId: json["studentID"],
        studentName: json["studentName"],
        studentPicture: json["studentPicture"],
        classTeacherId: json["classTeacherID"],
        classTeacherName: json["classTeacherName"],
        classTeacherPhoto: json["classTeacherPhoto"],
    );

    Map<String, dynamic> toJson() => {
        "studentID": studentId,
        "studentName": studentName,
        "studentPicture": studentPicture,
        "classTeacherID": classTeacherId,
        "classTeacherName": classTeacherName,
        "classTeacherPhoto": classTeacherPhoto,
    };
}
