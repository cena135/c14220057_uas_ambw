import 'package:shared_preferences/shared_preferences.dart';

class SessionService {
  static Future<void> setSeenGetStarted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen_get_started', true);
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged_in', value);
  }
}