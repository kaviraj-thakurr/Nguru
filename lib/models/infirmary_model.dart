// To parse this JSON data, do
//
//     final infirmaryModel = infirmaryModelFromJson(jsonString);

import 'dart:convert';

InfirmaryModel infirmaryModelFromJson(String str) => InfirmaryModel.fromJson(json.decode(str));

String infirmaryModelToJson(InfirmaryModel data) => json.encode(data.toJson());

class InfirmaryModel {
    final List<IllnessList>? illnessList;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    InfirmaryModel({
        this.illnessList,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    InfirmaryModel copyWith({
        List<IllnessList>? illnessList,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        InfirmaryModel(
            illnessList: illnessList ?? this.illnessList,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory InfirmaryModel.fromJson(Map<String, dynamic> json) => InfirmaryModel(
        illnessList: json["IllnessList"] == null ? [] : List<IllnessList>.from(json["IllnessList"]!.map((x) => IllnessList.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "IllnessList": illnessList == null ? [] : List<dynamic>.from(illnessList!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class IllnessList {
    final int? illnessId;
    final String? illnessDate;
    final String? illnessHeading;
    final String? illnessDetails;
    final String? remarks;
    final String? medicine;
    final String? amountofDose;
    final int? totalRecords;

    IllnessList({
        this.illnessId,
        this.illnessDate,
        this.illnessHeading,
        this.illnessDetails,
        this.remarks,
        this.medicine,
        this.amountofDose,
        this.totalRecords,
    });

    IllnessList copyWith({
        int? illnessId,
        String? illnessDate,
        String? illnessHeading,
        String? illnessDetails,
        String? remarks,
        String? medicine,
        String? amountofDose,
        int? totalRecords,
    }) => 
        IllnessList(
            illnessId: illnessId ?? this.illnessId,
            illnessDate: illnessDate ?? this.illnessDate,
            illnessHeading: illnessHeading ?? this.illnessHeading,
            illnessDetails: illnessDetails ?? this.illnessDetails,
            remarks: remarks ?? this.remarks,
            medicine: medicine ?? this.medicine,
            amountofDose: amountofDose ?? this.amountofDose,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory IllnessList.fromJson(Map<String, dynamic> json) => IllnessList(
        illnessId: json["illnessID"],
        illnessDate: json["illnessDate"],
        illnessHeading: json["illnessHeading"],
        illnessDetails: json["illnessDetails"],
        remarks: json["remarks"],
        medicine: json["medicine"],
        amountofDose: json["amountofDose"],
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "illnessID": illnessId,
        "illnessDate": illnessDate,
        "illnessHeading": illnessHeading,
        "illnessDetails": illnessDetails,
        "remarks": remarks,
        "medicine": medicine,
        "amountofDose": amountofDose,
        "totalRecords": totalRecords,
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
