import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences._internal();

  static final Preferences _instance = Preferences._internal();

  factory Preferences() {
    return _instance;
  }

  late SharedPreferences _prefs;

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  get onBoarding {
    return _prefs.getBool("onBoarding") ?? false;
  }

  get tokenAuth {
    return _prefs.getString("token-auth") ?? "";
  }

  void setBoarding(bool boarding) {
    _prefs.setBool("onBoarding", boarding);
  }

  void setTokenAuth(String token) {
    _prefs.setString("token-auth", token);
  }
}
