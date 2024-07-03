import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static const String keyIsLoggedIn = 'isLoggedIn';
  static const String keyGetUserToken = 'token';

  // Save the login state
  static Future<void> setLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyIsLoggedIn, isLoggedIn);
  }

  // Get the login state
  static Future<bool> getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(keyIsLoggedIn) ?? false;
  }

  // Save the user ID
  static Future<void> setUserToken(String userToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyGetUserToken, userToken);
  }

  // Get the user ID
  static Future<String?> getUserTokens() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyGetUserToken);
  }

  // static String
}