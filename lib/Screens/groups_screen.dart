import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:securechat/Widgets/my_drawer.dart';
import 'package:securechat/Widgets/my_footer.dart';
import 'package:securechat/classes/routes.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  var db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  var logger = Logger();
  List<Map<String, dynamic>> chatroomsList = [];
  List<String> chatroomsIdList = [];

  Future<void> getGroupsChatRoom() async {
    try {
      await db.collection("chatrooms").get().then((dataSnapShot) {
        chatroomsList = [];
        for (var singleChatroomData in dataSnapShot.docs) {
          chatroomsList.add(singleChatroomData.data());
          chatroomsIdList.add(singleChatroomData.id.toString());
        }
        setState(() {});
      });
    } catch (e) {
      logger.d(e);
    }
  }

  @override
  void initState() {
    getGroupsChatRoom();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: const MyFooter(),
        appBar: AppBar(
          title: const Text("GroupChat"),
        ),
        drawer: const MyDrawer(),
        body: RefreshIndicator(
          onRefresh: () async {
            await getGroupsChatRoom();
            return;
          },
          child: ListView.builder(
              itemCount: chatroomsList.length,
              itemBuilder: (BuildContext context, int index) {
                String chatRoomName =
                    chatroomsList[index]["chatroom_name"] ?? 'Did not found';
                String chatRoomDesc = chatroomsList[index]["desc"] ?? '';
                String chatRoomId = chatroomsIdList[index];

                return ListTile(
                  onTap: () {
                    Routes.toChatRoomScreen(
                        context: context,
                        chatRoomId: chatRoomId,
                        chatRoomName: chatRoomName);
                  },
                  splashColor: Colors.blue,
                  title: Text(chatRoomName),
                  subtitle: Text(chatRoomDesc),
                  leading: CircleAvatar(
                    child: Text(chatRoomName[0]),
                  ),
                );
                // ;
              }),
        ));
  }
}
