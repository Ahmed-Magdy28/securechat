import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:securechat/Screens/Profile/profile_edit.dart';
import 'package:securechat/Screens/calls_screen.dart';
import 'package:securechat/Screens/chat_room_screen.dart';
import 'package:securechat/Screens/dashboard_screen.dart';
import 'package:securechat/Screens/groups_screen.dart';
import 'package:securechat/Screens/login_screen.dart';
import 'package:securechat/Screens/passwordReset/forget_password_screen.dart';
import 'package:securechat/Screens/Profile/profile_screen.dart';
import 'package:securechat/Screens/settings_screen.dart';
import 'package:securechat/Screens/signup_screen.dart';
import 'package:securechat/Screens/updates_screen.dart';
import 'package:securechat/providers/user_provider.dart';

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
    Provider.of<UserProvider>(context, listen: false).getUserData();
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
      Provider.of<UserProvider>(context, listen: false).getUserData();
      Routes.openDashBoard(context: context);
    }
  }

  static void profileRoute({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ProfileScreen(),
      ),
    );
  }

  static void settingRoute({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  static void groupsChat({required BuildContext context}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const GroupsScreen(),
      ),
    );
  }

  static void updateScreenRoute({required BuildContext context}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const UpdatesScreen(),
      ),
    );
  }

  static void callsScreenRoute({required BuildContext context}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const CallsScreen(),
      ),
    );
  }

  static void toEditProfile({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EditProfileScreen(),
      ),
    );
  }

  static void toChatRoomScreen(
      {required BuildContext context, required String chatRoomName, required String chatRoomId}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatRoomScreen(
          chatRoomName: chatRoomName,
          chatRoomId: chatRoomId,
        ),
      ),
    );
  }
}
