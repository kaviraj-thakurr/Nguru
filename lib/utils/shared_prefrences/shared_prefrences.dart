import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _userIDKey = 'userID';
  static const String _schoolIDKey = 'schoolID';
  static const String _studentIDKey = 'studentID';
  static const String _schoolUrl = "schoolUrl";
  static const String _sessionID = "sessionId";
  static const String _isLoggedIn = "LoggedIn";

  // Save UserID
  static Future<void> saveSessionID(int sessionID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_sessionID, sessionID);
  }

  // Save UserID
  static Future<void> saveSchoolUrl(String schoolUrl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_schoolUrl, schoolUrl);
  }

  // Save UserID
  static Future<void> saveUserID(int userID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIDKey, userID);
  }

  // Save SchoolID
  static Future<void> saveSchoolID(int schoolID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_schoolIDKey, schoolID);
  }

  // Save StudentID
  static Future<void> saveStudentID(int studentID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_studentIDKey, studentID);
  }

  // Save logged in status
  static Future<void> saveLoggedInStatus(bool isLoggedIn) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedIn.toString(), isLoggedIn);
  }






/////////////////////////////////////////////////////////////////// GETTERS



  // Get UserID
  static Future<int?> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIDKey);
  }

  // Get SchoolID
  static Future<int?> getSchoolID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_schoolIDKey);
  }

  // Get StudentID
  static Future<int?> getStudentID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_studentIDKey);
  }

  // Get UserID
  static Future<String?> getSchoolUrl() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getString(_schoolUrl);
  }

  // Get UserID
  static Future<int?> getSessionId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(_sessionID);
  }

  // Get logged in status
  static Future<bool?> getLoggedInStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(_isLoggedIn);
  }





//////////////////////////////////////////////////// CLEARING ALL SHARED PREFS





  // Clear all saved data
  static Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIDKey);
    await prefs.remove(_schoolIDKey);
    await prefs.remove(_studentIDKey);
  }
}
