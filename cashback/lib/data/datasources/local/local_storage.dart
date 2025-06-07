import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/exceptions/auth_exceptions.dart';

class LocalStorage {
  final SharedPreferences _prefs;

  LocalStorage(this._prefs);

  // Auth Tokens
  Future<void> saveAuthToken(String token) async {
    await _prefs.setString('auth_token', token);
  }

  String? getAuthToken() {
    return _prefs.getString('auth_token');
  }

  Future<void> clearAuthToken() async {
    await _prefs.remove('auth_token');
  }

  // User Data
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _prefs.setString('user_data', json.encode(userData));
  }

  Map<String, dynamic>? getUserData() {
    final data = _prefs.getString('user_data');
    return data != null ? json.decode(data) : null;
  }

  Future<void> clearUserData() async {
    await _prefs.remove('user_data');
  }

  // App Settings
  bool getDarkModeEnabled() {
    return _prefs.getBool('dark_mode') ?? false;
  }

  Future<void> setDarkModeEnabled(bool enabled) async {
    await _prefs.setBool('dark_mode', enabled);
  }

  // Last Known Location
  Future<void> saveLastLocation(double lat, double lng) async {
    await _prefs.setDouble('last_lat', lat);
    await _prefs.setDouble('last_lng', lng);
  }

  (double, double)? getLastLocation() {
    final lat = _prefs.getDouble('last_lat');
    final lng = _prefs.getDouble('last_lng');
    return (lat != null && lng != null) ? (lat, lng) : null;
  }
}
