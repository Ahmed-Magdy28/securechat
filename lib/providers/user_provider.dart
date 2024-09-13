import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class UserProvider extends ChangeNotifier {
  String userName = "";
  String userEmail = "";
  String userId = "";
  String userCountry = "";
  String userImage = "";
  Map<String, dynamic>? userData = {};

  var db = FirebaseFirestore.instance;
  var user = FirebaseAuth.instance.currentUser;
  var logger = Logger();

  void getUserData() async {
    try {
      if (user != null) {
        await db.collection("users").doc(user!.uid).get().then((dataSnapShot) {
          userData = dataSnapShot.data();
          userName = dataSnapShot.data()?["name"] ?? "";
          userEmail = dataSnapShot.data()?["email"] ?? "";
          userId = dataSnapShot.data()?["id"] ?? "";
          userCountry = dataSnapShot.data()?["country"] ?? "";
          userImage = dataSnapShot.data()?["profileImage"] ?? "";
          notifyListeners();
        });
      }
    } catch (e) {
      logger.d(e);
    }
  }
}
