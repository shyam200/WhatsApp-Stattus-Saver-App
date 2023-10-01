import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

///SharedPreference Manager is to provide all getter and setters of persistence storage
class SharedPreferenceManager {
  final SharedPreferences sharedPreferences;

  const SharedPreferenceManager({required this.sharedPreferences});

  //Method to read string value from persistence storage
  String? getString(String key, {String? defaultValue}) {
    try {
      if (containsKey(key)) {
        return sharedPreferences.getString(key);
      }
    } catch (exception) {
      log('Unable to get string value, $exception');
    }

    return defaultValue;
  }

  //Method to save string value in persistence storage
  Future<bool> setString(String key, String value) async {
    try {
      return await sharedPreferences.setString(key, value);
    } catch (exception) {
      log('Unable to set string value, $exception');
    }

    return false;
  }

  //Method to read boolean value from persistence storage
  bool getBool(String key, {defaultValue}) {
    try {
      if (containsKey(key)) {
        return sharedPreferences.getBool(key) ?? false;
      }
    } catch (exception) {
      log('Unable to get bool value, $exception');
    }

    return defaultValue;
  }

  //Method to save bool value in persistence storage
  Future<bool> setBool(String key, bool value) async {
    try {
      return await sharedPreferences.setBool(key, value);
    } catch (exception) {
      log('Unable to set bool value, $exception');
    }

    return false;
  }

  /// Reads a value from persistent storage
  int? getInt(String key, {int? defaultValue}) {
    try {
      if (containsKey(key)) {
        return sharedPreferences.getInt(key);
      }
    } catch (exception) {
      log('Unable to get Int value, $exception');
    }
    return defaultValue;
  }

  /// Saves an integer [value] to persistent storage in the background.
  Future<bool> setInt(String key, int value) async {
    try {
      return await sharedPreferences.setInt(key, value);
    } catch (exception) {
      log('Unable to set Int value, $exception');
    }
    return false;
  }

  /// Reads a value from persistent storage
  double? getDouble(String key, {double? defaultValue}) {
    try {
      if (containsKey(key)) {
        return sharedPreferences.getDouble(key);
      }
    } catch (exception) {
      log('Unable to get Double value, $exception');
    }
    return defaultValue;
  }

  /// Saves a double [value] to persistent storage in the background.
  Future<bool> setDouble(String key, double value) async {
    try {
      return await sharedPreferences.setDouble(key, value);
    } catch (exception) {
      log('Unable to set Double value, $exception');
    }
    return false;
  }

  /// Returns true if persistent storage contains the given [key].
  bool containsKey(String key) {
    return sharedPreferences.containsKey(key);
  }
}
