import 'dart:convert';

AssignmentsMonthList assignmentsMonthListFromJson(String str) => AssignmentsMonthList.fromJson(json.decode(str));

String assignmentsMonthListToJson(AssignmentsMonthList data) => json.encode(data.toJson());

class AssignmentsMonthList {
    List<AssignmentMonthList> assignmentMonthList;
    String responseCode;
    String responseMessage;

    AssignmentsMonthList({
        required this.assignmentMonthList,
        required this.responseCode,
        required this.responseMessage,
    });

    factory AssignmentsMonthList.fromJson(Map<String, dynamic> json) => AssignmentsMonthList(
        assignmentMonthList: List<AssignmentMonthList>.from(json["assignmentMonthList"].map((x) => AssignmentMonthList.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "assignmentMonthList": List<dynamic>.from(assignmentMonthList.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class AssignmentMonthList {
    int dayKey;
    int assignmentStatus;
    DateTime calendarDate;

    AssignmentMonthList({
        required this.dayKey,
        required this.assignmentStatus,
        required this.calendarDate,
    });

    factory AssignmentMonthList.fromJson(Map<String, dynamic> json) => AssignmentMonthList(
        dayKey: json["dayKey"],
        assignmentStatus: json["assignmentStatus"],
        calendarDate: DateTime.parse(json["calendarDate"]),
    );

    Map<String, dynamic> toJson() => {
        "dayKey": dayKey,
        "assignmentStatus": assignmentStatus,
        "calendarDate": calendarDate.toIso8601String(),
    };
}
