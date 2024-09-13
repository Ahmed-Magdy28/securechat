import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:securechat/Widgets/my_drawer.dart';
import 'package:securechat/Widgets/my_footer.dart';

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

  Future<void> getGroupsChatRoom() async {
    try {
      await db.collection("chatrooms").get().then((dataSnapShot) {
        for (var singleChatroomData in dataSnapShot.docs) {
          chatroomsList.add(singleChatroomData.data());
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
                return ListTile(
                  onTap: () {},
                  splashColor: Colors.blue,
                  title: Text(chatroomsList[index]["chatroom_name"] ?? ''),
                  subtitle: Text(chatroomsList[index]["desc"] ?? ''),
                  leading: CircleAvatar(
                    child: Text(chatroomsList[index]["chatroom_name"][0] ?? ''),
                  ),
                );
                // ;
              }),
        ));
  }
}
