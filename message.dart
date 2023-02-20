import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Message {
  String? senderId;
  String? messageId;
  ValueNotifier<int> messageListener = ValueNotifier<int>(0);
  List<MessageData> chat = [];
  Message({required this.messageId, required this.senderId});
  DatabaseReference messageDatabase = FirebaseDatabase.instance.ref("message");

  sendMessage(String messageString) {
    String status = "waiting";
    DateTime dt = DateTime.now();
    messageDatabase.child(messageId!).push().set({
      "date_time": dt.toString(),
      "message": messageString,
      "sender_id": senderId
    });
  }

  startMessageReceive(
    Function(List chatMessage) onMessage,
  ) {
    messageDatabase.child(messageId!).onValue.listen((event) {
      chat.clear();
      for (var data in event.snapshot.children) {
        MessageData mg = MessageData(
            message: data.child("message").value.toString(),
            dateTime: data.child("date_time").value.toString(),
            messageId: data.key,
            senderId: data.child("sender_id").value.toString());
        chat.add(mg);
      }
      onMessage(chat);
    });
  }
}

class MessageData {
  String? senderId;
  String? messageId;
  String? dateTime;
  String? message;
  MessageData(
      {required this.message,
      required this.dateTime,
      required this.messageId,
      required this.senderId});
}
