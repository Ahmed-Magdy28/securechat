import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignupController {
  static var logger = Logger();

  static Future<bool> createAccount(
      {required BuildContext context,
      required String email,
      required String password,
      required String name,
      required String country}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      var userId = FirebaseAuth.instance.currentUser!.uid;
      var db = FirebaseFirestore.instance;
      Map<String, dynamic> data = {
        "name": name,
        "country": country,
        "email": email,
        "id": userId.toString(),
        "profileImage": ""
      };
      try {
        await db.collection("users").doc(userId.toString()).set(data);
      } catch (e) {
        logger.d(e);
        SnackBar messageSnakeBar = SnackBar(
            backgroundColor: Colors.red[400], content: Text(e.toString()));

        ScaffoldMessenger.of(context).showSnackBar(messageSnakeBar);
      }
      return true;
    } catch (e) {
      logger.d(e);
      SnackBar messageSnakeBar = SnackBar(
          backgroundColor: Colors.red[400], content: Text(e.toString()));

      ScaffoldMessenger.of(context).showSnackBar(messageSnakeBar);
      return false;
    }
  }
}
