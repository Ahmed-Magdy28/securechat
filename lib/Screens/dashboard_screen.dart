import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:securechat/Widgets/my_drawer.dart';
import 'package:securechat/Widgets/my_footer.dart';
import 'package:securechat/classes/routes.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  Map<String, dynamic>? userData = {};

  var db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MyDrawer(),
        bottomNavigationBar: const MyFooter(),
        appBar: AppBar(
          title: const Text('SecureChat'),
        ),
        body: SizedBox.expand(
          child: Center(
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Routes.groupsChat(context: context);
                  },
                  splashColor: Colors.green,
                  title: const Text("GroupChat"),
                  leading: const Icon(Icons.group),
                )
              ],
            ),
          ),
        ));
  }
}
