// To parse this JSON data, do
//
//     final libraryIssuedBookModel = libraryIssuedBookModelFromJson(jsonString);

import 'dart:convert';

LibraryIssuedBookModel libraryIssuedBookModelFromJson(String str) => LibraryIssuedBookModel.fromJson(json.decode(str));

String libraryIssuedBookModelToJson(LibraryIssuedBookModel data) => json.encode(data.toJson());

class LibraryIssuedBookModel {
    final List<LibraryIssued>? libraryIssued;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    LibraryIssuedBookModel({
        this.libraryIssued,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    LibraryIssuedBookModel copyWith({
        List<LibraryIssued>? libraryIssued,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        LibraryIssuedBookModel(
            libraryIssued: libraryIssued ?? this.libraryIssued,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory LibraryIssuedBookModel.fromJson(Map<String, dynamic> json) => LibraryIssuedBookModel(
        libraryIssued: json["libraryIssued"] == null ? [] : List<LibraryIssued>.from(json["libraryIssued"]!.map((x) => LibraryIssued.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "libraryIssued": libraryIssued == null ? [] : List<dynamic>.from(libraryIssued!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class LibraryIssued {
    final int? bookId;
    final int? accessionNo;
    final int? issueReturnId;
    final int? type;
    final String? bookName;
    final String? issueDate;
    final String? dueDate;
    final int? totalRecords;

    LibraryIssued({
        this.bookId,
        this.accessionNo,
        this.issueReturnId,
        this.type,
        this.bookName,
        this.issueDate,
        this.dueDate,
        this.totalRecords,
    });

    LibraryIssued copyWith({
        int? bookId,
        int? accessionNo,
        int? issueReturnId,
        int? type,
        String? bookName,
        String? issueDate,
        String? dueDate,
        int? totalRecords,
    }) => 
        LibraryIssued(
            bookId: bookId ?? this.bookId,
            accessionNo: accessionNo ?? this.accessionNo,
            issueReturnId: issueReturnId ?? this.issueReturnId,
            type: type ?? this.type,
            bookName: bookName ?? this.bookName,
            issueDate: issueDate ?? this.issueDate,
            dueDate: dueDate ?? this.dueDate,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory LibraryIssued.fromJson(Map<String, dynamic> json) => LibraryIssued(
        bookId: json["bookID"],
        accessionNo: json["accessionNo"],
        issueReturnId: json["issueReturnId"],
        type: json["type"],
        bookName: json["bookName"],
        issueDate: json["issueDate"],
        dueDate: json["dueDate"],
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "bookID": bookId,
        "accessionNo": accessionNo,
        "issueReturnId": issueReturnId,
        "type": type,
        "bookName": bookName,
        "issueDate": issueDate,
        "dueDate": dueDate,
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
