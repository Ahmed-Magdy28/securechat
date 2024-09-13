import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:securechat/Widgets/my_footer.dart';
import 'package:securechat/classes/routes.dart';
import 'package:securechat/providers/user_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                Routes.toEditProfile(context: context);
              },
              icon: const Icon(Icons.edit))
        ],
      ),
      bottomNavigationBar: const MyFooter(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: (userProvider.userImage != '')
                  ? Image.network(userProvider.userImage)
                  : CircleAvatar(
                      radius: 60, child: Text(userProvider.userName[0])),
            ),
            Column(
              children: [
                ListTile(
                    onTap: () {},
                    title: Center(
                      child: Text(
                        userProvider.userName,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    )),
                ListTile(
                    onTap: () {},
                    title: Center(
                        child: Text(
                      userProvider.userEmail,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ))),
                ListTile(
                    onTap: () {},
                    title: Center(
                        child: Text(
                      userProvider.userCountry,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
