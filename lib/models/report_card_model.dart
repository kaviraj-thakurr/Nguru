// To parse this JSON data, do
//
//     final reportCardModel = reportCardModelFromJson(jsonString);

import 'dart:convert';

ReportCardModel reportCardModelFromJson(String str) => ReportCardModel.fromJson(json.decode(str));

String reportCardModelToJson(ReportCardModel data) => json.encode(data.toJson());

class ReportCardModel {
    final List<Report>? report;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    ReportCardModel({
        this.report,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    ReportCardModel copyWith({
        List<Report>? report,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        ReportCardModel(
            report: report ?? this.report,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory ReportCardModel.fromJson(Map<String, dynamic> json) => ReportCardModel(
        report: json["report"] == null ? [] : List<Report>.from(json["report"]!.map((x) => Report.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "report": report == null ? [] : List<dynamic>.from(report!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class Pagination {
    final int? pageNumber;
    final int? totalRecords;
    final int? maxPages;
    final int? visibleThreshold;

    Pagination({
        this.pageNumber,
        this.totalRecords,
        this.maxPages,
        this.visibleThreshold,
    });

    Pagination copyWith({
        int? pageNumber,
        int? totalRecords,
        int? maxPages,
        int? visibleThreshold,
    }) => 
        Pagination(
            pageNumber: pageNumber ?? this.pageNumber,
            totalRecords: totalRecords ?? this.totalRecords,
            maxPages: maxPages ?? this.maxPages,
            visibleThreshold: visibleThreshold ?? this.visibleThreshold,
        );

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        pageNumber: json["pageNumber"],
        totalRecords: json["totalRecords"],
        maxPages: json["maxPages"],
        visibleThreshold: json["visibleThreshold"],
    );

    Map<String, dynamic> toJson() => {
        "pageNumber": pageNumber,
        "totalRecords": totalRecords,
        "maxPages": maxPages,
        "visibleThreshold": visibleThreshold,
    };
}

class Report {
    final String? fileName;
    final String? reportName;
    final String? reportCaption;
    final String? isPublished;
    final String? reportUrl;
    final dynamic sessionName;
    final int? totalRecords;

    Report({
        this.fileName,
        this.reportName,
        this.reportCaption,
        this.isPublished,
        this.reportUrl,
        this.sessionName,
        this.totalRecords,
    });

    Report copyWith({
        String? fileName,
        String? reportName,
        String? reportCaption,
        String? isPublished,
        String? reportUrl,
        dynamic sessionName,
        int? totalRecords,
    }) => 
        Report(
            fileName: fileName ?? this.fileName,
            reportName: reportName ?? this.reportName,
            reportCaption: reportCaption ?? this.reportCaption,
            isPublished: isPublished ?? this.isPublished,
            reportUrl: reportUrl ?? this.reportUrl,
            sessionName: sessionName ?? this.sessionName,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory Report.fromJson(Map<String, dynamic> json) => Report(
        fileName: json["fileName"],
        reportName: json["reportName"],
        reportCaption: json["reportCaption"],
        isPublished: json["isPublished"],
        reportUrl: json["reportURL"],
        sessionName: json["sessionName"],
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "fileName": fileName,
        "reportName": reportName,
        "reportCaption": reportCaption,
        "isPublished": isPublished,
        "reportURL": reportUrl,
        "sessionName": sessionName,
        "totalRecords": totalRecords,
    };
}
