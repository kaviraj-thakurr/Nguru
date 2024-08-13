import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static const String _userIDKey = 'userID';
  static const String _schoolIDKey = 'schoolID';
  static const String _studentIDKey = 'studentID';

  // Save UserID
static  Future<void> saveUserID(int userID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_userIDKey, userID);
  }

  // Save SchoolID
static  Future<void> saveSchoolID(int schoolID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_schoolIDKey, schoolID);
  }

  // Save StudentID
 static Future<void> saveStudentID(int studentID) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_studentIDKey, studentID);
  }

  // Get UserID
static  Future<int?> getUserID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_userIDKey);
  }

  // Get SchoolID
static  Future<int?> getSchoolID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_schoolIDKey);
  }

  // Get StudentID
 static Future<int?> getStudentID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_studentIDKey);
  }

  // Clear all saved data
static  Future<void> clearData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userIDKey);
    await prefs.remove(_schoolIDKey);
    await prefs.remove(_studentIDKey);
  }
}