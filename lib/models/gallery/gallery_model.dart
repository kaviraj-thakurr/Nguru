import 'dart:convert';

GalleryPhotosModel galleryPhotosModelFromJson(String str) => GalleryPhotosModel.fromJson(json.decode(str));

String galleryPhotosModelToJson(GalleryPhotosModel data) => json.encode(data.toJson());

class GalleryPhotosModel {
    List<PhotogalleryList>? photogalleryList;
    Pagination? pagination;
    String? responseCode;
    String? responseMessage;

    GalleryPhotosModel({
        this.photogalleryList,
        this.pagination,
        this.responseCode,
        this.responseMessage,
    });

    GalleryPhotosModel copyWith({
        List<PhotogalleryList>? photogalleryList,
        Pagination? pagination,
        String? responseCode,
        String? responseMessage,
    }) => 
        GalleryPhotosModel(
            photogalleryList: photogalleryList ?? this.photogalleryList,
            pagination: pagination ?? this.pagination,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory GalleryPhotosModel.fromJson(Map<String, dynamic> json) => GalleryPhotosModel(
        photogalleryList: json["photogalleryList"] == null ? [] : List<PhotogalleryList>.from(json["photogalleryList"]!.map((x) => PhotogalleryList.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "photogalleryList": photogalleryList == null ? [] : List<dynamic>.from(photogalleryList!.map((x) => x.toJson())),
        "pagination": pagination?.toJson(),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class Pagination {
    int? pageNumber;
    int? totalRecords;
    int? maxPages;
    int? visibleThreshold;

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

class PhotogalleryList {
    int? galleryId;
    String? description;
    List<PhotoList>? photoList;
    int? totalRecords;

    PhotogalleryList({
        this.galleryId,
        this.description,
        this.photoList,
        this.totalRecords,
    });

    PhotogalleryList copyWith({
        int? galleryId,
        String? description,
        List<PhotoList>? photoList,
        int? totalRecords,
    }) => 
        PhotogalleryList(
            galleryId: galleryId ?? this.galleryId,
            description: description ?? this.description,
            photoList: photoList ?? this.photoList,
            totalRecords: totalRecords ?? this.totalRecords,
        );

    factory PhotogalleryList.fromJson(Map<String, dynamic> json) => PhotogalleryList(
        galleryId: json["galleryID"],
        description: json["description"],
        photoList: json["photoList"] == null ? [] : List<PhotoList>.from(json["photoList"]!.map((x) => PhotoList.fromJson(x))),
        totalRecords: json["totalRecords"],
    );

    Map<String, dynamic> toJson() => {
        "galleryID": galleryId,
        "description": description,
        "photoList": photoList == null ? [] : List<dynamic>.from(photoList!.map((x) => x.toJson())),
        "totalRecords": totalRecords,
    };
}

class PhotoList {
    int? photoId;
    String? photo;

    PhotoList({
        this.photoId,
        this.photo,
    });

    PhotoList copyWith({
        int? photoId,
        String? photo,
    }) => 
        PhotoList(
            photoId: photoId ?? this.photoId,
            photo: photo ?? this.photo,
        );

    factory PhotoList.fromJson(Map<String, dynamic> json) => PhotoList(
        photoId: json["photoID"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "photoID": photoId,
        "photo": photo,
    };
}
