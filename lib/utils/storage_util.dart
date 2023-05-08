import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) == null) {
      return null;
    } else {
      return jsonDecode(prefs.getString(key) ?? "");
    }
  }

  static setData(String key, data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, jsonEncode(data));
  }

  static getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static clearData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
