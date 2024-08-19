// To parse this JSON data, do
//
//     final galleryPhotosModel = galleryPhotosModelFromJson(jsonString);

import 'dart:convert';

GalleryPhotosModel galleryPhotosModelFromJson(String str) => GalleryPhotosModel.fromJson(json.decode(str));

String galleryPhotosModelToJson(GalleryPhotosModel data) => json.encode(data.toJson());

class GalleryPhotosModel {
    final List<PhotoList>? photoList;
    final String? responseCode;
    final String? responseMessage;

    GalleryPhotosModel({
        this.photoList,
        this.responseCode,
        this.responseMessage,
    });

    GalleryPhotosModel copyWith({
        List<PhotoList>? photoList,
        String? responseCode,
        String? responseMessage,
    }) => 
        GalleryPhotosModel(
            photoList: photoList ?? this.photoList,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory GalleryPhotosModel.fromJson(Map<String, dynamic> json) => GalleryPhotosModel(
        photoList: json["photoList"] == null ? [] : List<PhotoList>.from(json["photoList"]!.map((x) => PhotoList.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "photoList": photoList == null ? [] : List<dynamic>.from(photoList!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class PhotoList {
    final String? fileDesc;
    final String? photo;

    PhotoList({
        this.fileDesc,
        this.photo,
    });

    PhotoList copyWith({
        String? fileDesc,
        String? photo,
    }) => 
        PhotoList(
            fileDesc: fileDesc ?? this.fileDesc,
            photo: photo ?? this.photo,
        );

    factory PhotoList.fromJson(Map<String, dynamic> json) => PhotoList(
        fileDesc: json["fileDesc"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "fileDesc": fileDesc,
        "photo": photo,
    };
}
