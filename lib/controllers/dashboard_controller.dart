import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:securechat/classes/routes.dart';

class DashboardController {
  static Future<void> logoutFunc({required BuildContext context}) async {
    await FirebaseAuth.instance.signOut();
    Routes.loginMaster(context: context);
  }
}
