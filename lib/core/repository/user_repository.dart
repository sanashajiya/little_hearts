import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static const String _keyGender = 'user_gender';
  static const String _keyUsername = 'user_username';

  Future<String?> getGender() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyGender);
    } catch (e) {
      return null;
    }
  }

  Future<String?> getUsername() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyUsername);
    } catch (e) {
      return null;
    }
  }

  Future<bool> saveGender(String gender) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_keyGender, gender.toLowerCase());
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveUsername(String username) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_keyUsername, username);
    } catch (e) {
      return false;
    }
  }

  Future<bool> clearUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyGender);
      await prefs.remove(_keyUsername);
      return true;
    } catch (e) {
      return false;
    }
  }
}



