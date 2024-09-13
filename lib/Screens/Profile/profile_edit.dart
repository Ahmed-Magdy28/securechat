import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:securechat/Widgets/my_footer.dart';
import 'package:securechat/providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  var db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  TextEditingController newUserName = TextEditingController();
  TextEditingController newUserEmail = TextEditingController();
  TextEditingController newUserCountry = TextEditingController();
  TextEditingController newUserImage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.save))],
      ),
      bottomNavigationBar: const MyFooter(),
      body: Center(
          child: Form(
              child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: newUserName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required';
                } else {
                  return null;
                }
              },
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: newUserImage,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Image is required';
                } else {
                  return null;
                }
              },
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(labelText: 'ImageLink'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: newUserEmail,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } else if (!value.contains('@') && !value.contains('.com')) {
                  return 'Please enter true Email';
                } else {
                  return null;
                }
              },
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(labelText: 'New email'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: newUserCountry,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Country is required';
                } else {
                  return null;
                }
              },
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(labelText: 'Country'),
            ),
          ),
        ],
      ))),
    );
  }
}
