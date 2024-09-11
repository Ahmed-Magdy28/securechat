import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:securechat/Screens/dashboard_screen.dart';
import 'package:securechat/Screens/login_screen.dart';
import 'package:securechat/Screens/passwordReset/forget_password_screen.dart';
import 'package:securechat/Screens/profile_screen.dart';
import 'package:securechat/Screens/settings_screen.dart';
import 'package:securechat/Screens/signup_screen.dart';

class Routes {
  static void forgetPassword({required BuildContext context}) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ForgetPasswordScreen()));
  }

  static void openSignUp({required BuildContext context}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const SignUpScreen()));
  }

  static void openDashBoard({required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashBoardScreen()),
        (route) => false);
  }

  static void openLogin({required BuildContext context}) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  static void loginMaster({required BuildContext context}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }

  static void chooseRoute(
      {required BuildContext context, required User? user}) {
    if (user == null) {
      Routes.openLogin(context: context);
    } else {
      Routes.openDashBoard(context: context);
    }
  }

  static void profileRoute(
      {required BuildContext context,
      required Map<String, dynamic>? userData}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(userData: userData),
      ),
    );
  }

  static void settingRoute(
      {required BuildContext context,
      required Map<String, dynamic>? userData}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(userData: userData),
      ),
    );
  }
}
