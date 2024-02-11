/// [Singleton] class to hold the [common used data] across the app
class WsAppData {
  bool _isDarkMode = false;

  set setDarkMode(darkMode) {
    _isDarkMode = darkMode;
  }

  bool get isDarkMode => _isDarkMode;
}
