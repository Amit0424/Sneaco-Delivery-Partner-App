import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  // Generic method to save data
  static Future<void> saveData<T>(String key, T value) async {
    if (value.runtimeType == String) {
      await instance.setString(key, value as String);
    } else if (value.runtimeType == int) {
      await instance.setInt(key, value as int);
    } else if (value.runtimeType == double) {
      await instance.setDouble(key, value as double);
    } else if (value.runtimeType == bool) {
      await instance.setBool(key, value as bool);
    } else if (value.runtimeType == List) {
      await instance.setStringList(key, value as List<String>);
    }
  }

  // Generic method to save data
  static Object? readData<T>(String key) {
    return instance.get(key);
  }

  // Generic method to remove data
  static Future<void> removeData<T>(String key) async {
    await instance.remove(key);
  }

  // Generic method to update data
 static Future<void> clearAll() async {
    await instance.clear();
  }
}
