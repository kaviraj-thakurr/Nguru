// To parse this JSON data, do
//
//     final chatSendButton = chatSendButtonFromJson(jsonString);

import 'dart:convert';

ChatSendButton chatSendButtonFromJson(String str) => ChatSendButton.fromJson(json.decode(str));

String chatSendButtonToJson(ChatSendButton data) => json.encode(data.toJson());

class ChatSendButton {
    final String? responseCode;
    final String? responseMessage;

    ChatSendButton({
        this.responseCode,
        this.responseMessage,
    });

    ChatSendButton copyWith({
        String? responseCode,
        String? responseMessage,
    }) => 
        ChatSendButton(
            responseCode: responseCode ?? this.responseCode,
            responseMessage: responseMessage ?? this.responseMessage,
        );

    factory ChatSendButton.fromJson(Map<String, dynamic> json) => ChatSendButton(
        responseCode: json["responseCode"],
        responseMessage: json["responseMessage"],
    );

    Map<String, dynamic> toJson() => {
        "responseCode": responseCode,
        "responseMessage": responseMessage,
    };
}
