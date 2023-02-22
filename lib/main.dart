import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testing/chatList.dart';
import 'package:testing/method/message.dart';
import 'package:testing/method/messageList.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Message message;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    message = Message(
      senderId: "sabarinath",
      receiverId: "kannan",
    );
    MessageList messageList = MessageList(user_id: "sabarinath");

    messageList.chatListener((chatData) {
      for (var chat in chatData) {}
    });
  }

  loadMessage() {
    message.startMessageListerner((chatMessage) {
      for (MessageData mess in chatMessage) {
        // if true , it's send by the user, else it's receive by user
        print(mess.from);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => chatList()));
                },
                child: Text("hello world"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
