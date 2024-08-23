// To parse this JSON data, do
//
//     final vaccinationModel = vaccinationModelFromJson(jsonString);

import 'dart:convert';

VaccinationModel vaccinationModelFromJson(String str) => VaccinationModel.fromJson(json.decode(str));

String vaccinationModelToJson(VaccinationModel data) => json.encode(data.toJson());

class VaccinationModel {
    final List<VaccinationList>? vaccinationList;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    VaccinationModel({
        this.vaccinationList,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    VaccinationModel copyWith({
        List<VaccinationList>? vaccinationList,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        VaccinationModel(
            vaccinationList: vaccinationList ?? this.vaccinationList,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory VaccinationModel.fromJson(Map<String, dynamic> json) => VaccinationModel(
        vaccinationList: json["VaccinationList"] == null ? [] : List<VaccinationList>.from(json["VaccinationList"]!.map((x) => VaccinationList.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "VaccinationList": vaccinationList == null ? [] : List<dynamic>.from(vaccinationList!.map((x) => x.toJson())),
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

class VaccinationList {
    final int? vaccinationId;
    final String? vaccinationHeading;
    final String? vaccinationDate;
    final String? vaccinationDetails;
    final int? totalRecords;

    VaccinationList({
        this.vaccinationId,
        this.vaccinationHeading,
        this.vaccinationDate,
        this.vaccinationDetails,
        this.totalRecords,
    });

    VaccinationList copyWith({
        int? vaccinationId,
        String? vaccinationHeading,
        String? vaccinationDate,
        String? vaccinationDetails,
        int? totalRecords,
    }) => 
        VaccinationList(
            vaccinationId: vaccinationId ?? this.vaccinationId,
            vaccinationHeading: vaccinationHeading ?? this.vaccinationHeading,
            vaccinationDate: vaccinationDate ?? this.vaccinationDate,
            vaccinationDetails: vaccinationDetails ?? this.vaccinationDetails,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory VaccinationList.fromJson(Map<String, dynamic> json) => VaccinationList(
        vaccinationId: json["vaccinationID"],
        vaccinationHeading: json["vaccinationHeading"],
        vaccinationDate: json["vaccinationDate"],
        vaccinationDetails: json["vaccinationDetails"],
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "vaccinationID": vaccinationId,
        "vaccinationHeading": vaccinationHeading,
        "vaccinationDate": vaccinationDate,
        "vaccinationDetails": vaccinationDetails,
        "totalRecords": totalRecords,
    };
}
