import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

import 'method/message.dart';

class CHAT extends StatefulWidget {
  String recieverId;
  String senderID;
  String ChannelID;
  CHAT(
      {super.key,
      required this.senderID,
      required this.recieverId,
      this.ChannelID = ""});

  @override
  State<CHAT> createState() => _CHATState(
      senderID: senderID, recieverId: recieverId, ChannelID: ChannelID);
}

class _CHATState extends State<CHAT> {
  String recieverId;
  String senderID;
  String ChannelID;
  _CHATState(
      {required this.senderID, required this.recieverId, this.ChannelID = ""});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    message = Message(
        senderId: senderID, receiverId: recieverId, messageId: ChannelID);

    loadMessag();
  }

  late Message message;

  List<MessageData> mess = [];
  loadMessag() {
    message.startMessageListerner((chatMessage) {
      setState(() {
        mess = chatMessage;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            TextField(
              onSubmitted: (value) {
                message.sendMessage(value);
                if (!message.IsReady && message.messageId != "") loadMessag();
              },
            ),
            for (int i = 0; i < mess.length; i++) Text(mess[i].message!)
          ],
        ),
      ),
    );
  }
}
