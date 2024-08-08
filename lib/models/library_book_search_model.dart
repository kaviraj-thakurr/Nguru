// To parse this JSON data, do
//
//     final librarySearchBookModel = librarySearchBookModelFromJson(jsonString);

import 'dart:convert';

LibrarySearchBookModel librarySearchBookModelFromJson(String str) => LibrarySearchBookModel.fromJson(json.decode(str));

String librarySearchBookModelToJson(LibrarySearchBookModel data) => json.encode(data.toJson());

class LibrarySearchBookModel {
    final List<LibrarySearch>? librarySearch;
    final Pagination? pagination;
    final String? responseCode;
    final String? responseMessage;

    LibrarySearchBookModel({
        this.librarySearch,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    LibrarySearchBookModel copyWith({
        List<LibrarySearch>? librarySearch,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        LibrarySearchBookModel(
            librarySearch: librarySearch ?? this.librarySearch,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory LibrarySearchBookModel.fromJson(Map<String, dynamic> json) => LibrarySearchBookModel(
        librarySearch: json["librarySearch"] == null ? [] : List<LibrarySearch>.from(json["librarySearch"]!.map((x) => LibrarySearch.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "librarySearch": librarySearch == null ? [] : List<dynamic>.from(librarySearch!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class LibrarySearch {
    final int? bookId;
    final int? accessionNo;
    final int? issueReturnId;
    final String? bookName;
    final String? authorName;
    final String? publisherName;
    final String? keywords;
    final String? status;
    final int? isBooked;
    final String? issueDate;
    final String? returnDate;
    final int? totalRecords;

    LibrarySearch({
        this.bookId,
        this.accessionNo,
        this.issueReturnId,
        this.bookName,
        this.authorName,
        this.publisherName,
        this.keywords,
        this.status,
        this.isBooked,
        this.issueDate,
        this.returnDate,
        this.totalRecords,
    });

    LibrarySearch copyWith({
        int? bookId,
        int? accessionNo,
        int? issueReturnId,
        String? bookName,
        String? authorName,
        String? publisherName,
        String? keywords,
        String? status,
        int? isBooked,
        String? issueDate,
        String? returnDate,
        int? totalRecords,
    }) => 
        LibrarySearch(
            bookId: bookId ?? this.bookId,
            accessionNo: accessionNo ?? this.accessionNo,
            issueReturnId: issueReturnId ?? this.issueReturnId,
            bookName: bookName ?? this.bookName,
            authorName: authorName ?? this.authorName,
            publisherName: publisherName ?? this.publisherName,
            keywords: keywords ?? this.keywords,
            status: status ?? this.status,
            isBooked: isBooked ?? this.isBooked,
            issueDate: issueDate ?? this.issueDate,
            returnDate: returnDate ?? this.returnDate,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory LibrarySearch.fromJson(Map<String, dynamic> json) => LibrarySearch(
        bookId: json["bookID"],
        accessionNo: json["accessionNo"],
        issueReturnId: json["issueReturnId"],
        bookName: json["bookName"],
        authorName: json["authorName"],
        publisherName: json["publisherName"],
        keywords: json["keywords"],
        status: json["status"],
        isBooked: json["isBooked"],
        issueDate: json["issueDate"],
        returnDate: json["returnDate"],
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "bookID": bookId,
        "accessionNo": accessionNo,
        "issueReturnId": issueReturnId,
        "bookName": bookName,
        "authorName": authorName,
        "publisherName": publisherName,
        "keywords": keywords,
        "status": status,
        "isBooked": isBooked,
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
