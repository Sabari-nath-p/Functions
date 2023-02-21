import 'package:firebase_database/firebase_database.dart';

class MessageList {
  String? user_id; // user id of current user
  DatabaseReference db = FirebaseDatabase.instance.ref("chat_list");
  MessageList({required this.user_id});

  chatListener(Function(List<chatData> chatData) newMessage) {
    db.child(user_id!).orderByChild("data_time").onValue.listen((event) {
      List<chatData> chatList = [];
      for (var chat in event.snapshot.children) {
        chatData data = chatData(
            channelID: chat.child("message_id").value.toString(),
            dateTime: chat.child("date_time").value.toString(),
            receiverID: chat.key,
            lastMessage: chat.child("last_message").value.toString());
        chatList.add(data);
        //    print(chatList[0].channelID);
      }

      chatList.sort((a, b) => DateTime.parse(a.dateTime.toString())
          .compareTo(DateTime.parse(b.dateTime.toString())));
      //  print(chatList[0].channelID);
      newMessage(chatList);
    });
  }
}

class chatData {
  String? lastMessage;
  String? dateTime;
  String? channelID;
  String? receiverID;

  chatData(
      {required this.channelID,
      required this.dateTime,
      required this.receiverID,
      required this.lastMessage});
}
