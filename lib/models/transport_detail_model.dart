// To parse this JSON data, do
//
//     final transportDetails = transportDetailsFromJson(jsonString);

import 'dart:convert';

TransportDetails transportDetailsFromJson(String str) => TransportDetails.fromJson(json.decode(str));

String transportDetailsToJson(TransportDetails data) => json.encode(data.toJson());

class TransportDetails {
    final String? driverName;
    final String? routeNo;
    final dynamic contactNo;
    final String? pickupLocation;
    final String? dropLocation;
    final String? pickupLat;
    final String? pickupLong;
    final String? dropupLat;
    final String? dropLong;
    final String? busLat;
    final String? busLong;
    final int? routeid;
    final int? gpsDesk;
    final dynamic gpsDeskUrl;
    final List<RouteInfo>? routeInfo;
    final String? responseCode;
    final String? responseMessage;

    TransportDetails({
        this.driverName,
        this.routeNo,
        this.contactNo,
        this.pickupLocation,
        this.dropLocation,
        this.pickupLat,
        this.pickupLong,
        this.dropupLat,
        this.dropLong,
        this.busLat,
        this.busLong,
        this.routeid,
        this.gpsDesk,
        this.gpsDeskUrl,
        this.routeInfo,
        this.responseCode,
        this.responseMessage,
    });

    TransportDetails copyWith({
        String? driverName,
        String? routeNo,
        dynamic contactNo,
        String? pickupLocation,
        String? dropLocation,
        String? pickupLat,
        String? pickupLong,
        String? dropupLat,
        String? dropLong,
        String? busLat,
        String? busLong,
        int? routeid,
        int? gpsDesk,
        dynamic gpsDeskUrl,
        List<RouteInfo>? routeInfo,
        String? responseCode,
        String? responseMessage,
    }) => 
        TransportDetails(
            driverName: driverName ?? this.driverName,
            routeNo: routeNo ?? this.routeNo,
            contactNo: contactNo ?? this.contactNo,
            pickupLocation: pickupLocation ?? this.pickupLocation,
            dropLocation: dropLocation ?? this.dropLocation,
            pickupLat: pickupLat ?? this.pickupLat,
            pickupLong: pickupLong ?? this.pickupLong,
            dropupLat: dropupLat ?? this.dropupLat,
            dropLong: dropLong ?? this.dropLong,
            busLat: busLat ?? this.busLat,
            busLong: busLong ?? this.busLong,
            routeid: routeid ?? this.routeid,
            gpsDesk: gpsDesk ?? this.gpsDesk,
            gpsDeskUrl: gpsDeskUrl ?? this.gpsDeskUrl,
            routeInfo: routeInfo ?? this.routeInfo,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory TransportDetails.fromJson(Map<String, dynamic> json) => TransportDetails(
        driverName: json["driverName"],
        routeNo: json["routeNo"],
        contactNo: json["contactNo"],
        pickupLocation: json["pickupLocation"],
        dropLocation: json["dropLocation"],
        pickupLat: json["pickupLat"],
        pickupLong: json["pickupLong"],
        dropupLat: json["dropupLat"],
        dropLong: json["dropLong"],
        busLat: json["busLat"],
        busLong: json["busLong"],
        routeid: json["routeid"],
        gpsDesk: json["gpsDesk"],
        gpsDeskUrl: json["gpsDeskUrl"],
        routeInfo: json["routeInfo"] == null ? [] : List<RouteInfo>.from(json["routeInfo"]!.map((x) => RouteInfo.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "driverName": driverName,
        "routeNo": routeNo,
        "contactNo": contactNo,
        "pickupLocation": pickupLocation,
        "dropLocation": dropLocation,
        "pickupLat": pickupLat,
        "pickupLong": pickupLong,
        "dropupLat": dropupLat,
        "dropLong": dropLong,
        "busLat": busLat,
        "busLong": busLong,
        "routeid": routeid,
        "gpsDesk": gpsDesk,
        "gpsDeskUrl": gpsDeskUrl,
        "routeInfo": routeInfo == null ? [] : List<dynamic>.from(routeInfo!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class RouteInfo {
    final String? routeId;
    final String? busStopId;
    final String? busStopName;
    final String? latitude;
    final String? longitude;
    final String? isLastDrop;
    final String? isRoutePickDrop;

    RouteInfo({
        this.routeId,
        this.busStopId,
        this.busStopName,
        this.latitude,
        this.longitude,
        this.isLastDrop,
        this.isRoutePickDrop,
    });

    RouteInfo copyWith({
        String? routeId,
        String? busStopId,
        String? busStopName,
        String? latitude,
        String? longitude,
        String? isLastDrop,
        String? isRoutePickDrop,
    }) => 
        RouteInfo(
            routeId: routeId ?? this.routeId,
            busStopId: busStopId ?? this.busStopId,
            busStopName: busStopName ?? this.busStopName,
            latitude: latitude ?? this.latitude,
            longitude: longitude ?? this.longitude,
            isLastDrop: isLastDrop ?? this.isLastDrop,
            isRoutePickDrop: isRoutePickDrop ?? this.isRoutePickDrop,
        );

    factory RouteInfo.fromJson(Map<String, dynamic> json) => RouteInfo(
        routeId: json["RouteId"],
        busStopId: json["BusStopId"],
        busStopName: json["BusStopName"],
        latitude: json["Latitude"],
        longitude: json["Longitude"],
        isLastDrop: json["IsLastDrop"],
        isRoutePickDrop: json["IsRoutePickDrop"],
    );

    Map<String, dynamic> toJson() => {
        "RouteId": routeId,
        "BusStopId": busStopId,
        "BusStopName": busStopName,
        "Latitude": latitude,
        "Longitude": longitude,
        "IsLastDrop": isLastDrop,
        "IsRoutePickDrop": isRoutePickDrop,
    };
}
