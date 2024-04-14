import 'package:flutter/material.dart';
import 'package:pothole_detection/modules/login/presentation/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late SharedPreferences _preferences;

  Future initialise() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const String AUTH_TOKEN = 'authToken';
  static const String USER_ID = 'userID';
  static const String USER_ROLE = 'role';
  static const String USER_NAME = 'username';
  static const String USER_EMAIL = 'email';

  void _saveToDisk<T>(String key, T content) {
    if (content is String) {
      _preferences.setString(key, content);
    }
    if (content is bool) {
      _preferences.setBool(key, content);
    }
    if (content is int) {
      _preferences.setInt(key, content);
    }
    if (content is double) {
      _preferences.setDouble(key, content);
    }
    if (content is List<String>) {
      _preferences.setStringList(key, content);
    }
  }

  dynamic _getFromDisk(String key) {
    var value = _preferences.get(key);
    return value;
  }

  Future<void> clearLoginData(BuildContext context) async {
    await _preferences.remove(AUTH_TOKEN);
    await _preferences.remove(USER_EMAIL);
    await _preferences.remove(USER_ROLE);
    await _preferences.remove(USER_NAME);
    await _preferences.remove(USER_ID);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  Future<void> clearNotificationData() async {}

  String get authToken => _getFromDisk(AUTH_TOKEN) ?? "";
  set authToken(String value) => _saveToDisk(AUTH_TOKEN, value);

  String get userID => _getFromDisk(USER_ID) ?? "";
  set userID(String value) => _saveToDisk(USER_ID, value);

  String get userRole => _getFromDisk(USER_ROLE) ?? "";
  set userRole(String value) => _saveToDisk(USER_ROLE, value);

  String get userName => _getFromDisk(USER_NAME) ?? "";
  set userName(String value) => _saveToDisk(USER_NAME, value);

  String get userEmail => _getFromDisk(USER_EMAIL) ?? "";
  set userEmail(String value) => _saveToDisk(USER_EMAIL, value);
}
