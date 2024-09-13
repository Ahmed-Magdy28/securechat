import 'package:flutter/material.dart';
import 'package:securechat/classes/routes.dart';

class MyFooter extends StatefulWidget {
  const MyFooter({super.key});

  @override
  State<MyFooter> createState() => _MyFooterState();
}

class _MyFooterState extends State<MyFooter> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              Routes.openDashBoard(context: context);
            },
            child: const Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Icon(Icons.chat),
                SizedBox(
                  height: 5,
                ),
                Text("Chats")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Routes.updateScreenRoute(context: context);
            },
            child: const Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Icon(Icons.update),
                SizedBox(
                  height: 5,
                ),
                Text("Updates")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Routes.groupsChat(context: context);
            },
            child: const Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Icon(Icons.group),
                SizedBox(
                  height: 5,
                ),
                Text("Communities")
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Routes.callsScreenRoute(context: context);
            },
            child: const Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Icon(Icons.call),
                SizedBox(
                  height: 5,
                ),
                Text("Calls")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
