import 'package:shared_preferences/shared_preferences.dart';

class CommonConfigRepository {
  static const String _darkMode = "darkMode";

  final SharedPreferences _preferences;

  CommonConfigRepository(this._preferences);

  Future<void> setDarkMode(bool value) async {
    _preferences.setBool(_darkMode, value);
  }

  bool getDarkMode() {
    return _preferences.getBool(_darkMode) ?? false;
  }
}
