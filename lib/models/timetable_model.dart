// To parse this JSON data, do
//
//     final timeTableModel = timeTableModelFromJson(jsonString);

import 'dart:convert';

TimeTableModel timeTableModelFromJson(String str) => TimeTableModel.fromJson(json.decode(str));

String timeTableModelToJson(TimeTableModel data) => json.encode(data.toJson());

class TimeTableModel {
    final List<ListTimeTable>? listTimeTable;
    final String? responseCode;
    final String? responseMessage;

    TimeTableModel({
        this.listTimeTable,
        this.responseCode,
        this.responseMessage,
    });

    TimeTableModel copyWith({
        List<ListTimeTable>? listTimeTable,
        String? responseCode,
        String? responseMessage,
    }) => 
        TimeTableModel(
            listTimeTable: listTimeTable ?? this.listTimeTable,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory TimeTableModel.fromJson(Map<String, dynamic> json) => TimeTableModel(
        listTimeTable: json["listTimeTable"] == null ? [] : List<ListTimeTable>.from(json["listTimeTable"]!.map((x) => ListTimeTable.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "listTimeTable": listTimeTable == null ? [] : List<dynamic>.from(listTimeTable!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class ListTimeTable {
    final int? studentId;
    final int? id;
    final int? periodSrNo;
    final String? time;
    final String? period;
    final String? mon;
    final String? monPeriodTeacher;
    final String? tues;
    final String? tuesPeriodTeacher;
    final String? wed;
    final String? wedPeriodTeacher;
    final String? thur;
    final String? thurPeriodTeacher;
    final String? fri;
    final String? friPeriodTeacher;
    final dynamic sat;
    final dynamic satPeriodTeacher;
    final dynamic sun;
    final dynamic sunPeriodTeacher;

    ListTimeTable({
        this.studentId,
        this.id,
        this.periodSrNo,
        this.time,
        this.period,
        this.mon,
        this.monPeriodTeacher,
        this.tues,
        this.tuesPeriodTeacher,
        this.wed,
        this.wedPeriodTeacher,
        this.thur,
        this.thurPeriodTeacher,
        this.fri,
        this.friPeriodTeacher,
        this.sat,
        this.satPeriodTeacher,
        this.sun,
        this.sunPeriodTeacher,
    });

    ListTimeTable copyWith({
        int? studentId,
        int? id,
        int? periodSrNo,
        String? time,
        String? period,
        String? mon,
        String? monPeriodTeacher,
        String? tues,
        String? tuesPeriodTeacher,
        String? wed,
        String? wedPeriodTeacher,
        String? thur,
        String? thurPeriodTeacher,
        String? fri,
        String? friPeriodTeacher,
        dynamic sat,
        dynamic satPeriodTeacher,
        dynamic sun,
        dynamic sunPeriodTeacher,
    }) => 
        ListTimeTable(
            studentId: studentId ?? this.studentId,
            id: id ?? this.id,
            periodSrNo: periodSrNo ?? this.periodSrNo,
            time: time ?? this.time,
            period: period ?? this.period,
            mon: mon ?? this.mon,
            monPeriodTeacher: monPeriodTeacher ?? this.monPeriodTeacher,
            tues: tues ?? this.tues,
            tuesPeriodTeacher: tuesPeriodTeacher ?? this.tuesPeriodTeacher,
            wed: wed ?? this.wed,
            wedPeriodTeacher: wedPeriodTeacher ?? this.wedPeriodTeacher,
            thur: thur ?? this.thur,
            thurPeriodTeacher: thurPeriodTeacher ?? this.thurPeriodTeacher,
            fri: fri ?? this.fri,
            friPeriodTeacher: friPeriodTeacher ?? this.friPeriodTeacher,
            sat: sat ?? this.sat,
            satPeriodTeacher: satPeriodTeacher ?? this.satPeriodTeacher,
            sun: sun ?? this.sun,
            sunPeriodTeacher: sunPeriodTeacher ?? this.sunPeriodTeacher,
        );

    factory ListTimeTable.fromJson(Map<String, dynamic> json) => ListTimeTable(
        studentId: json["studentId"],
        id: json["id"],
        periodSrNo: json["periodSrNo"],
        time: json["time"],
        period: json["period"],
        mon: json["mon"],
        monPeriodTeacher: json["monPeriodTeacher"],
        tues: json["tues"],
        tuesPeriodTeacher: json["tuesPeriodTeacher"],
        wed: json["wed"],
        wedPeriodTeacher: json["wedPeriodTeacher"],
        thur: json["thur"],
        thurPeriodTeacher: json["thurPeriodTeacher"],
        fri: json["fri"],
        friPeriodTeacher: json["friPeriodTeacher"],
        sat: json["sat"],
        satPeriodTeacher: json["satPeriodTeacher"],
        sun: json["sun"],
        sunPeriodTeacher: json["sunPeriodTeacher"],
    );

    Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "id": id,
        "periodSrNo": periodSrNo,
        "time": time,
        "period": period,
        "mon": mon,
        "monPeriodTeacher": monPeriodTeacher,
        "tues": tues,
        "tuesPeriodTeacher": tuesPeriodTeacher,
        "wed": wed,
        "wedPeriodTeacher": wedPeriodTeacher,
        "thur": thur,
        "thurPeriodTeacher": thurPeriodTeacher,
        "fri": fri,
        "friPeriodTeacher": friPeriodTeacher,
        "sat": sat,
        "satPeriodTeacher": satPeriodTeacher,
        "sun": sun,
        "sunPeriodTeacher": sunPeriodTeacher,
    };
}
