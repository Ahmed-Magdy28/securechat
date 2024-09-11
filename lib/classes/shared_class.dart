import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedClass {
  static var logger = Logger();

  static Future<void> saveData(
      {required String email, required String password}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      await prefs.setStringList('data', <String>[email, password]);
    } catch (e) {
      logger.d(e.toString());
    }
  }

  static Future<void> deleteData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('data');
    } catch (e) {
      logger.d(e.toString());
    }
  }



  static Future<void> getDataDB(
      {required FirebaseFirestore? db,
      required User? user,
      required Function(Map<String, dynamic>) setUserData}) async {
    try {
      if (db != null && user != null) {
        await db.collection("users").doc(user.uid).get().then((dataSnapShot) {
          Map<String, dynamic>? fetchedData = dataSnapShot.data();
          if (fetchedData != null) {
            setUserData(fetchedData);
          }
        });
      }
    } catch (e) {
      logger.d(e);
    }
  }
}
