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
}
