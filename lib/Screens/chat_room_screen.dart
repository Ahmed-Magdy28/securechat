import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:securechat/Widgets/single_chat_item.dart';
import 'package:securechat/providers/user_provider.dart';
import 'package:intl/intl.dart';

class ChatRoomScreen extends StatefulWidget {
  final String chatRoomName;
  final String chatRoomId;
  const ChatRoomScreen(
      {super.key, required this.chatRoomName, required this.chatRoomId});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  TextEditingController messageText = TextEditingController();
  Map<String, dynamic> messageToSend = {};
  var db = FirebaseFirestore.instance;
  var logger = Logger();

  Future<void> sendMessage() async {
    if (messageText.text.isEmpty) {
      return;
    }
    messageToSend = {
      "text": messageText.text,
      "sender_name": Provider.of<UserProvider>(context, listen: false).userName,
      "sender_id": Provider.of<UserProvider>(context, listen: false).userId,
      "chatroomId": widget.chatRoomId,
      "timestamp": FieldValue.serverTimestamp(),
      "timeNow": DateFormat('hh:mm a').format(DateTime.now()),
    };
    messageText.text = "";
    try {
      await db.collection("messages").add(messageToSend);
    } catch (e) {
      logger.d(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chatRoomName),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
                stream: db
                    .collection("messages")
                    .where("chatroomId", isEqualTo: widget.chatRoomId)
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    logger.d(snapshot.error);
                    return const Center(
                      child: Text("some error has occurred in snapshot"),
                    );
                  }

                  var allMessages = snapshot.data?.docs ?? [];

                  if (allMessages.isEmpty) {
                    return const Center(child: Text("no Messages yet"));
                  }
                  return ListView.builder(
                      reverse: true,
                      itemCount: allMessages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return singleChatItem(
                            context: context,
                            allMessages: allMessages,
                            index: index);
                      });
                }),
          ),
          Container(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: messageText,
                    decoration: const InputDecoration(
                        hintText: "Write Message Here",
                        border: InputBorder.none),
                  )),
                  IconButton(
                      onPressed: sendMessage, icon: const Icon(Icons.send))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
