import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:securechat/classes/routes.dart';
import 'package:securechat/classes/shared_class.dart';

class LoginController {
  static var logger = Logger();

  static Future<bool> signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return true;
    } catch (e) {
      logger.d(e);
      SnackBar messageSnakeBar = SnackBar(
          backgroundColor: Colors.red[400], content: Text(e.toString()));

      ScaffoldMessenger.of(context).showSnackBar(messageSnakeBar);
      return false;
    }
  }

  static Future<void> logInFunc(
      {required GlobalKey<FormState> userForm,
      required BuildContext context,
      required String email,
      required String password,
      required bool isChecked}) async {
    if (userForm.currentState!.validate()) {
      if (await LoginController.signIn(
          context: context, email: email, password: password)) {
        if (isChecked) {
          await SharedClass.saveData(
            email: email,
            password: password,
          );
        } else {
          await SharedClass.deleteData();
        }
        Routes.openDashBoard(context: context);
      }
    }
  }
}
