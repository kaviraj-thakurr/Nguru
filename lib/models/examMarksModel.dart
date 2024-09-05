// To parse this JSON data, do
//
//     final examMarksModel = examMarksModelFromJson(jsonString);

import 'dart:convert';

ExamMarksModel examMarksModelFromJson(String str) => ExamMarksModel.fromJson(json.decode(str));

String examMarksModelToJson(ExamMarksModel data) => json.encode(data.toJson());

class ExamMarksModel {
    final List<Examinationmarksmodel>? examinationmarksmodel;
    final String? responseCode;
    final String? responseMessage;

    ExamMarksModel({
        this.examinationmarksmodel,
        this.responseCode,
        this.responseMessage,
    });

    ExamMarksModel copyWith({
        List<Examinationmarksmodel>? examinationmarksmodel,
        String? responseCode,
        String? responseMessage,
    }) => 
        ExamMarksModel(
            examinationmarksmodel: examinationmarksmodel ?? this.examinationmarksmodel,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory ExamMarksModel.fromJson(Map<String, dynamic> json) => ExamMarksModel(
        examinationmarksmodel: json["examinationmarksmodel"] == null ? [] : List<Examinationmarksmodel>.from(json["examinationmarksmodel"]!.map((x) => Examinationmarksmodel.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "examinationmarksmodel": examinationmarksmodel == null ? [] : List<dynamic>.from(examinationmarksmodel!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class Examinationmarksmodel {
    final String? examName;
    final String? subjectName;
    final String? maxWrittenMarks;
    final String? writtenObtainMarks;
    final String? maxPracticalMarks;
    final String? practicalObtainMarks;
    final String? maxOralMarks;
    final String? oralObtainMarks;
    final String? maxProjectMarks;
    final String? projectObtainMarks;

    Examinationmarksmodel({
        this.examName,
        this.subjectName,
        this.maxWrittenMarks,
        this.writtenObtainMarks,
        this.maxPracticalMarks,
        this.practicalObtainMarks,
        this.maxOralMarks,
        this.oralObtainMarks,
        this.maxProjectMarks,
        this.projectObtainMarks,
    });

    Examinationmarksmodel copyWith({
        String? examName,
        String? subjectName,
        String? maxWrittenMarks,
        String? writtenObtainMarks,
        String? maxPracticalMarks,
        String? practicalObtainMarks,
        String? maxOralMarks,
        String? oralObtainMarks,
        String? maxProjectMarks,
        String? projectObtainMarks,
    }) => 
        Examinationmarksmodel(
            examName: examName ?? this.examName,
            subjectName: subjectName ?? this.subjectName,
            maxWrittenMarks: maxWrittenMarks ?? this.maxWrittenMarks,
            writtenObtainMarks: writtenObtainMarks ?? this.writtenObtainMarks,
            maxPracticalMarks: maxPracticalMarks ?? this.maxPracticalMarks,
            practicalObtainMarks: practicalObtainMarks ?? this.practicalObtainMarks,
            maxOralMarks: maxOralMarks ?? this.maxOralMarks,
            oralObtainMarks: oralObtainMarks ?? this.oralObtainMarks,
            maxProjectMarks: maxProjectMarks ?? this.maxProjectMarks,
            projectObtainMarks: projectObtainMarks ?? this.projectObtainMarks,
        );

    factory Examinationmarksmodel.fromJson(Map<String, dynamic> json) => Examinationmarksmodel(
        examName: json["ExamName"],
        subjectName: json["SubjectName"],
        maxWrittenMarks: json["MaxWrittenMarks"],
        writtenObtainMarks: json["WrittenObtainMarks"],
        maxPracticalMarks: json["MaxPracticalMarks"],
        practicalObtainMarks: json["PracticalObtainMarks"],
        maxOralMarks: json["MaxOralMarks"],
        oralObtainMarks: json["OralObtainMarks"],
        maxProjectMarks: json["MaxProjectMarks"],
        projectObtainMarks: json["ProjectObtainMarks"],
    );

    Map<String, dynamic> toJson() => {
        "ExamName": examName,
        "SubjectName": subjectName,
        "MaxWrittenMarks": maxWrittenMarks,
        "WrittenObtainMarks": writtenObtainMarks,
        "MaxPracticalMarks": maxPracticalMarks,
        "PracticalObtainMarks": practicalObtainMarks,
        "MaxOralMarks": maxOralMarks,
        "OralObtainMarks": oralObtainMarks,
        "MaxProjectMarks": maxProjectMarks,
        "ProjectObtainMarks": projectObtainMarks,
    };
}
