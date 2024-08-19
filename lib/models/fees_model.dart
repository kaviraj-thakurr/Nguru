// To parse this JSON data, do
//
//     final feesModel = feesModelFromJson(jsonString);

import 'dart:convert';

FeesModel feesModelFromJson(String str) => FeesModel.fromJson(json.decode(str));

String feesModelToJson(FeesModel data) => json.encode(data.toJson());

class FeesModel {
    List<FeeList>? feeList;
    String? responseCode;
    String? responseMessage;

    FeesModel({
        this.feeList,
        this.responseCode,
        this.responseMessage,
    });

    FeesModel copyWith({
        List<FeeList>? feeList,
        String? responseCode,
        String? responseMessage,
    }) => 
        FeesModel(
            feeList: feeList ?? this.feeList,
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory FeesModel.fromJson(Map<String, dynamic> json) => FeesModel(
        feeList: json["feeList"] == null ? [] : List<FeeList>.from(json["feeList"]!.map((x) => FeeList.fromJson(x))),
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "feeList": feeList == null ? [] : List<dynamic>.from(feeList!.map((x) => x.toJson())),
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}

class FeeList {
    int? receiptId;
    String? receiptNo;
    String? amount;
    String? paidAmount;
    String? balance;
    String? installment;
    DateTime? date;
    int? month;
    int? type;
    int? priority;

    FeeList({
        this.receiptId,
        this.receiptNo,
        this.amount,
        this.paidAmount,
        this.balance,
        this.installment,
        this.date,
        this.month,
        this.type,
        this.priority,
    });

    FeeList copyWith({
        int? receiptId,
        String? receiptNo,
        String? amount,
        String? paidAmount,
        String? balance,
        String? installment,
        DateTime? date,
        int? month,
        int? type,
        int? priority,
    }) => 
        FeeList(
            receiptId: receiptId ?? this.receiptId,
            receiptNo: receiptNo ?? this.receiptNo,
            amount: amount ?? this.amount,
            paidAmount: paidAmount ?? this.paidAmount,
            balance: balance ?? this.balance,
            installment: installment ?? this.installment,
            date: date ?? this.date,
            month: month ?? this.month,
            type: type ?? this.type,
            priority: priority ?? this.priority,
        );

    factory FeeList.fromJson(Map<String, dynamic> json) => FeeList(
        receiptId: json["receiptID"],
        receiptNo: json["receiptNo"],
        amount: json["amount"],
        paidAmount: json["paidAmount"],
        balance: json["balance"],
        installment: json["installment"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        month: json["month"],
        type: json["type"],
        priority: json["priority"],
    );

    Map<String, dynamic> toJson() => {
        "receiptID": receiptId,
        "receiptNo": receiptNo,
        "amount": amount,
        "paidAmount": paidAmount,
        "balance": balance,
        "installment": installment,
        "date": date?.toIso8601String(),
        "month": month,
        "type": type,
        "priority": priority,
    };
}
