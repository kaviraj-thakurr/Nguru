// To parse this JSON data, do
//
//     final galleryItemListModel = galleryItemListModelFromJson(jsonString);

import 'dart:convert';

GalleryItemListModel galleryItemListModelFromJson(String str) => GalleryItemListModel.fromJson(json.decode(str));

String galleryItemListModelToJson(GalleryItemListModel data) => json.encode(data.toJson());

class GalleryItemListModel {
    final List<GalleryList>? galleryList;
    final String? responseCode;
    final String? responseMessage;

    GalleryItemListModel({
        this.galleryList,
        this.responseCode,
        this.responseMessage,
    });

    GalleryItemListModel copyWith({
        List<GalleryList>? galleryList,
        String? responseCode,
        String? responseMessage,
    }) => 
        GalleryItemListModel(
            galleryList: galleryList ?? this.galleryList,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory GalleryItemListModel.fromJson(Map<String, dynamic> json) => GalleryItemListModel(
        galleryList: json["galleryList"] == null ? [] : List<GalleryList>.from(json["galleryList"]!.map((x) => GalleryList.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "galleryList": galleryList == null ? [] : List<dynamic>.from(galleryList!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class GalleryList {
    final int? dashPichtureGalleryId;
    final String? subject;

    GalleryList({
        this.dashPichtureGalleryId,
        this.subject,
    });

    GalleryList copyWith({
        int? dashPichtureGalleryId,
        String? subject,
    }) => 
        GalleryList(
            dashPichtureGalleryId: dashPichtureGalleryId ?? this.dashPichtureGalleryId,
            subject: subject ?? this.subject,
        );

    factory GalleryList.fromJson(Map<String, dynamic> json) => GalleryList(
        dashPichtureGalleryId: json["dashPichtureGalleryId"],
        subject: json["subject"],
    );

    Map<String, dynamic> toJson() => {
        "dashPichtureGalleryId": dashPichtureGalleryId,
        "subject": subject,
    };
}
