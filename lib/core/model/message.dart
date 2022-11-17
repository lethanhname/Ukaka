import 'package:flutter/material.dart';

class Message {
  //Message content
  String message;

  Message(
    this.message,
  );

  factory Message.fromJson(dynamic json) {
    return Message(
        json['message'] as String);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    return data;
  }
}
