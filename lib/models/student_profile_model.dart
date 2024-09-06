// To parse this JSON data, do
//
//     final studentProfileModel = studentProfileModelFromJson(jsonString);

import 'dart:convert';

StudentProfileModel studentProfileModelFromJson(String str) => StudentProfileModel.fromJson(json.decode(str));

String studentProfileModelToJson(StudentProfileModel data) => json.encode(data.toJson());

class StudentProfileModel {
    final PersonalInfo? personalInfo;
    final CorrespondenceInfo? correspondenceInfo;
    final TransportInfo? transportInfo;
    final ClassteacherInfo? classteacherInfo;
    final String? responseCode;
    final String? responseMessage;

    StudentProfileModel({
        this.personalInfo,
        this.correspondenceInfo,
        this.transportInfo,
        this.classteacherInfo,
        this.responseCode,
        this.responseMessage,
    });

    StudentProfileModel copyWith({
        PersonalInfo? personalInfo,
        CorrespondenceInfo? correspondenceInfo,
        TransportInfo? transportInfo,
        ClassteacherInfo? classteacherInfo,
        String? responseCode,
        String? responseMessage,
    }) => 
        StudentProfileModel(
            personalInfo: personalInfo ?? this.personalInfo,
            correspondenceInfo: correspondenceInfo ?? this.correspondenceInfo,
            transportInfo: transportInfo ?? this.transportInfo,
            classteacherInfo: classteacherInfo ?? this.classteacherInfo,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory StudentProfileModel.fromJson(Map<String, dynamic> json) => StudentProfileModel(
        personalInfo: json["personalInfo"] == null ? null : PersonalInfo.fromJson(json["personalInfo"]),
        correspondenceInfo: json["correspondenceInfo"] == null ? null : CorrespondenceInfo.fromJson(json["correspondenceInfo"]),
        transportInfo: json["transportInfo"] == null ? null : TransportInfo.fromJson(json["transportInfo"]),
        classteacherInfo: json["classteacherInfo"] == null ? null : ClassteacherInfo.fromJson(json["classteacherInfo"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "personalInfo": personalInfo?.toJson(),
        "correspondenceInfo": correspondenceInfo?.toJson(),
        "transportInfo": transportInfo?.toJson(),
        "classteacherInfo": classteacherInfo?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class ClassteacherInfo {
    final String? classTeacherName;
    final String? classTeacherPhoto;
    final String? employeeCode;
    final String? mobileNo;
    final String? emailId;

    ClassteacherInfo({
        this.classTeacherName,
        this.classTeacherPhoto,
        this.employeeCode,
        this.mobileNo,
        this.emailId,
    });

    ClassteacherInfo copyWith({
        String? classTeacherName,
        String? classTeacherPhoto,
        String? employeeCode,
        String? mobileNo,
        String? emailId,
    }) => 
        ClassteacherInfo(
            classTeacherName: classTeacherName ?? this.classTeacherName,
            classTeacherPhoto: classTeacherPhoto ?? this.classTeacherPhoto,
            employeeCode: employeeCode ?? this.employeeCode,
            mobileNo: mobileNo ?? this.mobileNo,
            emailId: emailId ?? this.emailId,
        );

    factory ClassteacherInfo.fromJson(Map<String, dynamic> json) => ClassteacherInfo(
        classTeacherName: json["classTeacherName"],
        classTeacherPhoto: json["classTeacherPhoto"],
        employeeCode: json["employeeCode"],
        mobileNo: json["mobileNo"],
        emailId: json["emailID"],
    );

    Map<String, dynamic> toJson() => {
        "classTeacherName": classTeacherName,
        "classTeacherPhoto": classTeacherPhoto,
        "employeeCode": employeeCode,
        "mobileNo": mobileNo,
        "emailID": emailId,
    };
}

class CorrespondenceInfo {
    final String? emailId;
    final String? mobileNo;
    final String? address;

    CorrespondenceInfo({
        this.emailId,
        this.mobileNo,
        this.address,
    });

    CorrespondenceInfo copyWith({
        String? emailId,
        String? mobileNo,
        String? address,
    }) => 
        CorrespondenceInfo(
            emailId: emailId ?? this.emailId,
            mobileNo: mobileNo ?? this.mobileNo,
            address: address ?? this.address,
        );

    factory CorrespondenceInfo.fromJson(Map<String, dynamic> json) => CorrespondenceInfo(
        emailId: json["emailID"],
        mobileNo: json["mobileNo"],
        address: json["address"],
    );

    Map<String, dynamic> toJson() => {
        "emailID": emailId,
        "mobileNo": mobileNo,
        "address": address,
    };
}

class PersonalInfo {
    final String? studentName;
    final String? className;
    final String? gender;
    final String? fatherName;
    final String? motherName;
    final String? admissionNumber;
    final String? section;
    final String? bloodGroup;
    final String? house;
    final String? studentPicture;
    final String? studentPicturePath;
    final int? castId;
    final String? castName;
    final int? religionId;
    final String? religionName;
    final String? aadharNumber;
    final String? emisNumber;
    final int? flag;
    final String? fatherPhoto;
    final String? motherPhoto;
    final List<CastList>? castList;
    final List<ReligionList>? religionList;

    PersonalInfo({
        this.studentName,
        this.className,
        this.gender,
        this.fatherName,
        this.motherName,
        this.admissionNumber,
        this.section,
        this.bloodGroup,
        this.house,
        this.studentPicture,
        this.studentPicturePath,
        this.castId,
        this.castName,
        this.religionId,
        this.religionName,
        this.aadharNumber,
        this.emisNumber,
        this.flag,
        this.fatherPhoto,
        this.motherPhoto,
        this.castList,
        this.religionList,
    });

    PersonalInfo copyWith({
        String? studentName,
        String? className,
        String? gender,
        String? fatherName,
        String? motherName,
        String? admissionNumber,
        String? section,
        String? bloodGroup,
        String? house,
        String? studentPicture,
        String? studentPicturePath,
        int? castId,
        String? castName,
        int? religionId,
        String? religionName,
        String? aadharNumber,
        String? emisNumber,
        int? flag,
        String? fatherPhoto,
        String? motherPhoto,
        List<CastList>? castList,
        List<ReligionList>? religionList,
    }) => 
        PersonalInfo(
            studentName: studentName ?? this.studentName,
            className: className ?? this.className,
            gender: gender ?? this.gender,
            fatherName: fatherName ?? this.fatherName,
            motherName: motherName ?? this.motherName,
            admissionNumber: admissionNumber ?? this.admissionNumber,
            section: section ?? this.section,
            bloodGroup: bloodGroup ?? this.bloodGroup,
            house: house ?? this.house,
            studentPicture: studentPicture ?? this.studentPicture,
            studentPicturePath: studentPicturePath ?? this.studentPicturePath,
            castId: castId ?? this.castId,
            castName: castName ?? this.castName,
            religionId: religionId ?? this.religionId,
            religionName: religionName ?? this.religionName,
            aadharNumber: aadharNumber ?? this.aadharNumber,
            emisNumber: emisNumber ?? this.emisNumber,
            flag: flag ?? this.flag,
            fatherPhoto: fatherPhoto ?? this.fatherPhoto,
            motherPhoto: motherPhoto ?? this.motherPhoto,
            castList: castList ?? this.castList,
            religionList: religionList ?? this.religionList,
        );

    factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
        studentName: json["studentName"],
        className: json["className"],
        gender: json["gender"],
        fatherName: json["fatherName"],
        motherName: json["motherName"],
        admissionNumber: json["admissionNumber"],
        section: json["section"],
        bloodGroup: json["bloodGroup"],
        house: json["house"],
        studentPicture: json["studentPicture"],
        studentPicturePath: json["studentPicturePath"],
        castId: json["castID"],
        castName: json["castName"],
        religionId: json["religionID"],
        religionName: json["religionName"],
        aadharNumber: json["aadharNumber"],
        emisNumber: json["emisNumber"],
        flag: json["flag"],
        fatherPhoto: json["fatherPhoto"],
        motherPhoto: json["motherPhoto"],
        castList: json["CastList"] == null ? [] : List<CastList>.from(json["CastList"]!.map((x) => CastList.fromJson(x))),
        religionList: json["ReligionList"] == null ? [] : List<ReligionList>.from(json["ReligionList"]!.map((x) => ReligionList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "studentName": studentName,
        "className": className,
        "gender": gender,
        "fatherName": fatherName,
        "motherName": motherName,
        "admissionNumber": admissionNumber,
        "section": section,
        "bloodGroup": bloodGroup,
        "house": house,
        "studentPicture": studentPicture,
        "studentPicturePath": studentPicturePath,
        "castID": castId,
        "castName": castName,
        "religionID": religionId,
        "religionName": religionName,
        "aadharNumber": aadharNumber,
        "emisNumber": emisNumber,
        "flag": flag,
        "fatherPhoto": fatherPhoto,
        "motherPhoto": motherPhoto,
        "CastList": castList == null ? [] : List<dynamic>.from(castList!.map((x) => x.toJson())),
        "ReligionList": religionList == null ? [] : List<dynamic>.from(religionList!.map((x) => x.toJson())),
    };
}

class CastList {
    final int? castId;
    final String? castName;

    CastList({
        this.castId,
        this.castName,
    });

    CastList copyWith({
        int? castId,
        String? castName,
    }) => 
        CastList(
            castId: castId ?? this.castId,
            castName: castName ?? this.castName,
        );

    factory CastList.fromJson(Map<String, dynamic> json) => CastList(
        castId: json["castID"],
        castName: json["castName"],
    );

    Map<String, dynamic> toJson() => {
        "castID": castId,
        "castName": castName,
    };
}

class ReligionList {
    final int? religionId;
    final String? religionName;

    ReligionList({
        this.religionId,
        this.religionName,
    });

    ReligionList copyWith({
        int? religionId,
        String? religionName,
    }) => 
        ReligionList(
            religionId: religionId ?? this.religionId,
            religionName: religionName ?? this.religionName,
        );

    factory ReligionList.fromJson(Map<String, dynamic> json) => ReligionList(
        religionId: json["religionID"],
        religionName: json["religionName"],
    );

    Map<String, dynamic> toJson() => {
        "religionID": religionId,
        "religionName": religionName,
    };
}

class TransportInfo {
    final String? pickupRoute;
    final String? pickupTime;
    final String? dropRoute;
    final String? dropTime;
    final String? transportIncharge;
    final String? busNo;

    TransportInfo({
        this.pickupRoute,
        this.pickupTime,
        this.dropRoute,
        this.dropTime,
        this.transportIncharge,
        this.busNo,
    });

    TransportInfo copyWith({
        String? pickupRoute,
        String? pickupTime,
        String? dropRoute,
        String? dropTime,
        String? transportIncharge,
        String? busNo,
    }) => 
        TransportInfo(
            pickupRoute: pickupRoute ?? this.pickupRoute,
            pickupTime: pickupTime ?? this.pickupTime,
            dropRoute: dropRoute ?? this.dropRoute,
            dropTime: dropTime ?? this.dropTime,
            transportIncharge: transportIncharge ?? this.transportIncharge,
            busNo: busNo ?? this.busNo,
        );

    factory TransportInfo.fromJson(Map<String, dynamic> json) => TransportInfo(
        pickupRoute: json["pickupRoute"],
        pickupTime: json["pickupTime"],
        dropRoute: json["dropRoute"],
        dropTime: json["dropTime"],
        transportIncharge: json["transportIncharge"],
        busNo: json["busNo"],
    );

    Map<String, dynamic> toJson() => {
        "pickupRoute": pickupRoute,
        "pickupTime": pickupTime,
        "dropRoute": dropRoute,
        "dropTime": dropTime,
        "transportIncharge": transportIncharge,
        "busNo": busNo,
    };
}
