// To parse this JSON data, do
//
//     final calendarEventModel = calendarEventModelFromJson(jsonString);

import 'dart:convert';

CalendarEventModel calendarEventModelFromJson(String str) => CalendarEventModel.fromJson(json.decode(str));

String calendarEventModelToJson(CalendarEventModel data) => json.encode(data.toJson());

class CalendarEventModel {
    final List<CalendarEventList>? calendarEventList;
    final String? responseCode;
    final String? responseMessage;

    CalendarEventModel({
        this.calendarEventList,
        this.responseCode,
        this.responseMessage,
    });

    CalendarEventModel copyWith({
        List<CalendarEventList>? calendarEventList,
        String? responseCode,
        String? responseMessage,
    }) => 
        CalendarEventModel(
            calendarEventList: calendarEventList ?? this.calendarEventList,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory CalendarEventModel.fromJson(Map<String, dynamic> json) => CalendarEventModel(
        calendarEventList: json["calendarEventList"] == null ? [] : List<CalendarEventList>.from(json["calendarEventList"]!.map((x) => CalendarEventList.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "calendarEventList": calendarEventList == null ? [] : List<dynamic>.from(calendarEventList!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class CalendarEventList {
    final int? dayKey;
    final int? status;
    final DateTime? calendarDate;
    final String? eventName;
    final String? details;
    final String? fromDate;
    final String? toDate;

    CalendarEventList({
        this.dayKey,
        this.status,
        this.calendarDate,
        this.eventName,
        this.details,
        this.fromDate,
        this.toDate,
    });

    CalendarEventList copyWith({
        int? dayKey,
        int? status,
        DateTime? calendarDate,
        String? eventName,
        String? details,
        String? fromDate,
        String? toDate,
    }) => 
        CalendarEventList(
            dayKey: dayKey ?? this.dayKey,
            status: status ?? this.status,
            calendarDate: calendarDate ?? this.calendarDate,
            eventName: eventName ?? this.eventName,
            details: details ?? this.details,
            fromDate: fromDate ?? this.fromDate,
            toDate: toDate ?? this.toDate,
        );

    factory CalendarEventList.fromJson(Map<String, dynamic> json) => CalendarEventList(
        dayKey: json["dayKey"],
        status: json["status"],
        calendarDate: json["calendarDate"] == null ? null : DateTime.parse(json["calendarDate"]),
        eventName: json["eventName"],
        details: json["details"],
        fromDate: json["fromDate"],
        toDate: json["toDate"],
    );

    Map<String, dynamic> toJson() => {
        "dayKey": dayKey,
        "status": status,
        "calendarDate": calendarDate?.toIso8601String(),
        "eventName": eventName,
        "details": details,
        "fromDate": fromDate,
        "toDate": toDate,
    };
}
