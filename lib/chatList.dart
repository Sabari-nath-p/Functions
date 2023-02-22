import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:testing/CHAT.dart';
import 'package:testing/method/messageList.dart';

class chatList extends StatefulWidget {
  const chatList({super.key});

  @override
  State<chatList> createState() => _chatListState();
}

class _chatListState extends State<chatList> {
  late MessageList messageList;

  List<chatData> chats = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messageList = MessageList(user_id: "sabarinath");
    messageList.chatListener((chatData) {
      setState(() {
        chats = chatData;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            SizedBox(
              height: 30,
            ),
            for (int i = 0; i < chats.length; i++)
              InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CHAT(
                            senderID: "sabarinath",
                            recieverId: chats[i].receiverID!,
                            ChannelID: chats[i].channelID!,
                          )));
                },
                child: Container(
                  width: 200,
                  height: 60,
                  margin: EdgeInsets.only(left: 10),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 22,
                        child: Text(
                          chats[i].lastMessage!,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Text(
                        chats[i].receiverID!,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
