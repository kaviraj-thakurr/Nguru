import 'dart:convert';

ContactUs contactUsFromJson(String str) => ContactUs.fromJson(json.decode(str));

String contactUsToJson(ContactUs data) => json.encode(data.toJson());

class ContactUs {
    String? address;
    String? email;
    String? mobileNumber;
    String? landlineNumber;
    String? schoolPhoto;
    String? responseCode;
    String? responseMessage;

    ContactUs({
        this.address,
        this.email,
        this.mobileNumber,
        this.landlineNumber,
        this.schoolPhoto,
        this.responseCode,
        this.responseMessage,
    });

    ContactUs copyWith({
        String? address,
        String? email,
        String? mobileNumber,
        String? landlineNumber,
        String? schoolPhoto,
        String? responseCode,
        String? responseMessage,
    }) => 
        ContactUs(
            address: address ?? this.address,
            email: email ?? this.email,
            mobileNumber: mobileNumber ?? this.mobileNumber,
            landlineNumber: landlineNumber ?? this.landlineNumber,
            schoolPhoto: schoolPhoto ?? this.schoolPhoto,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory ContactUs.fromJson(Map<String, dynamic> json) => ContactUs(
        address: json["address"],
        email: json["email"],
        mobileNumber: json["mobileNumber"],
        landlineNumber: json["landlineNumber"],
        schoolPhoto: json["schoolPhoto"],
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "address": address,
        "email": email,
        "mobileNumber": mobileNumber,
        "landlineNumber": landlineNumber,
        "schoolPhoto": schoolPhoto,
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}
