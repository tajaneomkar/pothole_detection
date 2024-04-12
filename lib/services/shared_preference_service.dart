import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late SharedPreferences _preferences;

  Future initialise() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static const String AUTH_TOKEN = 'authToken';
  static const String USER_ID = 'userID';
  static const String USER_ROLE = 'role';

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

  Future<void> clearLoginData() async {
    await _preferences.remove(AUTH_TOKEN);
  }

  Future<void> clearNotificationData() async {}

  String get authToken => _getFromDisk(AUTH_TOKEN) ?? "";
  set authToken(String value) => _saveToDisk(AUTH_TOKEN, value);

  String get userID => _getFromDisk(USER_ID) ?? "";
  set userID(String value) => _saveToDisk(USER_ID, value);

  String get userRole => _getFromDisk(USER_ROLE) ?? "";
  set userRole(String value) => _saveToDisk(USER_ROLE, value);
}
