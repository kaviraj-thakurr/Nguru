import 'dart:convert';

AssignmentList assignmentListFromJson(String str) => AssignmentList.fromJson(json.decode(str));

String assignmentListToJson(AssignmentList data) => json.encode(data.toJson());

class AssignmentList {
    List<SubjectList>? subjectList;
    String? responseCode;
    String? responseMessage;

    AssignmentList({
        this.subjectList,
        this.responseCode,
        this.responseMessage,
    });

    AssignmentList copyWith({
        List<SubjectList>? subjectList,
        String? responseCode,
        String? responseMessage,
    }) => 
        AssignmentList(
            subjectList: subjectList ?? this.subjectList,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory AssignmentList.fromJson(Map<String, dynamic> json) => AssignmentList(
        subjectList: json["subjectList"] == null ? [] : List<SubjectList>.from(json["subjectList"]!.map((x) => SubjectList.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "subjectList": subjectList == null ? [] : List<dynamic>.from(subjectList!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class SubjectList {
    int? subjectId;
    String? subjectName;
    List<Assignment>? assignments;

    SubjectList({
        this.subjectId,
        this.subjectName,
        this.assignments,
    });

    SubjectList copyWith({
        int? subjectId,
        String? subjectName,
        List<Assignment>? assignments,
    }) => 
        SubjectList(
            subjectId: subjectId ?? this.subjectId,
            subjectName: subjectName ?? this.subjectName,
            assignments: assignments ?? this.assignments,
        );

    factory SubjectList.fromJson(Map<String, dynamic> json) => SubjectList(
        subjectId: json["subjectID"],
        subjectName: json["subjectName"],
        assignments: json["assignments"] == null ? [] : List<Assignment>.from(json["assignments"]!.map((x) => Assignment.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "subjectID": subjectId,
        "subjectName": subjectName,
        "assignments": assignments == null ? [] : List<dynamic>.from(assignments!.map((x) => x.toJson())),
    };
}

class Assignment {
    String? assignmentName;
    String? assignmentDetail;
    String? assignmentPicture;
    int? subjectId;
    String? assignmentDate;
    String? fileName;
    String? fileDescription;
    String? fileType;
    String? fileContent;
    int? totalRecords;
    String? startDate;
    String? endDate;

    Assignment({
        this.assignmentName,
        this.assignmentDetail,
        this.assignmentPicture,
        this.subjectId,
        this.assignmentDate,
        this.fileName,
        this.fileDescription,
        this.fileType,
        this.fileContent,
        this.totalRecords,
        this.startDate,
        this.endDate,
    });

    Assignment copyWith({
        String? assignmentName,
        String? assignmentDetail,
        String? assignmentPicture,
        int? subjectId,
        String? assignmentDate,
        String? fileName,
        String? fileDescription,
        String? fileType,
        String? fileContent,
        int? totalRecords,
        String? startDate,
        String? endDate,
    }) => 
        Assignment(
            assignmentName: assignmentName ?? this.assignmentName,
            assignmentDetail: assignmentDetail ?? this.assignmentDetail,
            assignmentPicture: assignmentPicture ?? this.assignmentPicture,
            subjectId: subjectId ?? this.subjectId,
            assignmentDate: assignmentDate ?? this.assignmentDate,
            fileName: fileName ?? this.fileName,
            fileDescription: fileDescription ?? this.fileDescription,
            fileType: fileType ?? this.fileType,
            fileContent: fileContent ?? this.fileContent,
            totalRecords: totalRecords ?? this.totalRecords,
            startDate: startDate ?? this.startDate,
            endDate: endDate ?? this.endDate,
        );

    factory Assignment.fromJson(Map<String, dynamic> json) => Assignment(
        assignmentName: json["assignmentName"],
        assignmentDetail: json["assignmentDetail"],
        assignmentPicture: json["assignmentPicture"],
        subjectId: json["subjectID"],
        assignmentDate: json["assignmentDate"],
        fileName: json["fileName"],
        fileDescription: json["fileDescription"],
        fileType: json["fileType"],
        fileContent: json["fileContent"],
        totalRecords: json["totalRecords"],
        startDate: json["startDate"],
        endDate: json["endDate"],
    );

    Map<String, dynamic> toJson() => {
        "assignmentName": assignmentName,
        "assignmentDetail": assignmentDetail,
        "assignmentPicture": assignmentPicture,
        "subjectID": subjectId,
        "assignmentDate": assignmentDate,
        "fileName": fileName,
        "fileDescription": fileDescription,
        "fileType": fileType,
        "fileContent": fileContent,
        "totalRecords": totalRecords,
        "startDate": startDate,
        "endDate": endDate,
    };
}
