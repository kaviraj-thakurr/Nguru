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
        calendarEventList: json["calendarEventList"] == null ? [] : List<CalendarEventList>.from((json["calendarEventList"] as List).map((x) => CalendarEventList.fromJson(x))),
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
    final EventName? eventName;
    final String? details;
    final Date? fromDate;
    final Date? toDate;

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
        EventName? eventName,
        String? details,
        Date? fromDate,
        Date? toDate,
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
        eventName: json["eventName"] == null ? null : eventNameValues.map[json["eventName"]],
        details: json["details"],
        fromDate: json["fromDate"] == null ? null : dateValues.map[json["fromDate"]],
        toDate: json["toDate"] == null ? null : dateValues.map[json["toDate"]],
    );

    Map<String, dynamic> toJson() => {
        "dayKey": dayKey,
        "status": status,
        "calendarDate": calendarDate?.toIso8601String(),
        "eventName": eventName == null ? null : eventNameValues.reverse[eventName],
        "details": details,
        "fromDate": fromDate == null ? null : dateValues.reverse[fromDate],
        "toDate": toDate == null ? null : dateValues.reverse[toDate],
    };
}

enum EventName {
    EMPTY,
    THE_2_ND_SATURDAY_MAY,
    WORKER_S_DAY
}

final eventNameValues = EnumValues({
    "": EventName.EMPTY,
    "2nd Saturday-May": EventName.THE_2_ND_SATURDAY_MAY,
    "worker's Day": EventName.WORKER_S_DAY
});

enum Date {
    EMPTY,
    MAY_12024,
    MAY_42024
}

final dateValues = EnumValues({
    "": Date.EMPTY,
    "May  1 2024 ": Date.MAY_12024,
    "May  4 2024 ": Date.MAY_42024
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
