import 'package:shared_preferences/shared_preferences.dart';

// ! MVVM 구조의 실제 데이터들을 디스크에 저장하는 공간, 여기서 데이터를 보관하고 getter, setter를 가져다가 VM에서 사용함
class PlaybackConfigRepository {
  static const String _autoplay = "autoplay";
  static const String _muted = "muted";

  final SharedPreferences _preferences;
  PlaybackConfigRepository(this._preferences);

  Future<void> setMuted(bool value) async {
    _preferences.setBool(_muted, value);
  }

  Future<void> setAutoplay(bool value) async {
    _preferences.setBool(_autoplay, value);
  }

  bool getMuted() {
    return _preferences.getBool(_muted) ?? false;
  }

  bool getAutoplay() {
    return _preferences.getBool(_autoplay) ?? false;
  }
}
