// To parse this JSON data, do
//
//     final libraryHistoryModel = libraryHistoryModelFromJson(jsonString);

import 'dart:convert';

LibraryHistoryModel libraryHistoryModelFromJson(String str) => LibraryHistoryModel.fromJson(json.decode(str));

String libraryHistoryModelToJson(LibraryHistoryModel data) => json.encode(data.toJson());

class LibraryHistoryModel {
    final List<LibraryHistory>? libraryHistory;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    LibraryHistoryModel({
        this.libraryHistory,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    LibraryHistoryModel copyWith({
        List<LibraryHistory>? libraryHistory,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        LibraryHistoryModel(
            libraryHistory: libraryHistory ?? this.libraryHistory,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory LibraryHistoryModel.fromJson(Map<String, dynamic> json) => LibraryHistoryModel(
        libraryHistory: json["libraryHistory"] == null ? [] : List<LibraryHistory>.from(json["libraryHistory"]!.map((x) => LibraryHistory.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "libraryHistory": libraryHistory == null ? [] : List<dynamic>.from(libraryHistory!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class LibraryHistory {
    final int? bookId;
    final int? accessionNo;
    final int? issueReturnId;
    final int? type;
    final String? bookName;
    final String? issueDate;
    final String? returnDate;
    final int? totalRecords;

    LibraryHistory({
        this.bookId,
        this.accessionNo,
        this.issueReturnId,
        this.type,
        this.bookName,
        this.issueDate,
        this.returnDate,
        this.totalRecords,
    });

    LibraryHistory copyWith({
        int? bookId,
        int? accessionNo,
        int? issueReturnId,
        int? type,
        String? bookName,
        String? issueDate,
        String? returnDate,
        int? totalRecords,
    }) => 
        LibraryHistory(
            bookId: bookId ?? this.bookId,
            accessionNo: accessionNo ?? this.accessionNo,
            issueReturnId: issueReturnId ?? this.issueReturnId,
            type: type ?? this.type,
            bookName: bookName ?? this.bookName,
            issueDate: issueDate ?? this.issueDate,
            returnDate: returnDate ?? this.returnDate,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory LibraryHistory.fromJson(Map<String, dynamic> json) => LibraryHistory(
        bookId: json["bookID"],
        accessionNo: json["accessionNo"],
        issueReturnId: json["issueReturnId"],
        type: json["type"],
        bookName: json["bookName"],
        issueDate: json["issueDate"],
        returnDate: json["returnDate"],
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "bookID": bookId,
        "accessionNo": accessionNo,
        "issueReturnId": issueReturnId,
        "type": type,
        "bookName": bookName,
        "issueDate": issueDate,
        "returnDate": returnDate,
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
