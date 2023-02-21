import 'package:firebase_database/firebase_database.dart';

class Message {
  String? senderId;
  String? receiverId;
  String? messageId;
  bool IsReady = false;

  Message({
    required this.senderId,
    required this.receiverId,
    this.messageId = "",
  }) {
    if (messageId == "") {
      messageDatabase
          .child("chat_list")
          .child(senderId!)
          .child(receiverId!)
          .child("message_id")
          .once()
          .then((value) {
        print(value);
        if (value.snapshot.exists) {
          print(value.snapshot.exists);
          messageId = value.snapshot.value.toString();
        }
      });
    }
  }
  DatabaseReference messageDatabase = FirebaseDatabase.instance.ref();

  sendMessage(String messageString) {
    String status = "waiting";
    DateTime dt = DateTime.now();

    if (messageId == "") {
      messageId = messageDatabase.child("message").push().key;
    }
    messageDatabase.child("message").child(messageId!).push().set({
      "date_time": dt.toString(),
      "message": messageString,
      "sender_id": senderId
    });

    messageDatabase.child("chat_list").child(senderId!).child(receiverId!).set({
      "last_message": messageString,
      "date_time": dt.toString(),
      "message_id": messageId,
      "last": senderId
    });
    messageDatabase
        .child("chat_list")
        .child(receiverId!)
        .child(messageId!)
        .set({
      "last_message": messageString,
      "date_time": dt.toString(),
      "last": senderId
    });
  }

  startMessageListerner(
    Function(List<MessageData> chatMessage) onMessage,
  ) {
    print(messageId);
    messageDatabase.child("message").child(messageId!).onValue.listen((event) {
      List<MessageData> chat = [];
      if (event.snapshot.exists) {
        IsReady = true;
      }
      for (var data in event.snapshot.children) {
        MessageData mg = MessageData(
            message: data.child("message").value.toString(),
            dateTime: data.child("date_time").value.toString(),
            messageId: data.key,
            senderId: data.child("sender_id").value.toString());
        print(mg.senderId);
        if (mg.senderId == senderId) mg.from = true;
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
  bool from = false;
  MessageData(
      {required this.message,
      required this.dateTime,
      required this.messageId,
      required this.senderId,
      this.from = false});
}
