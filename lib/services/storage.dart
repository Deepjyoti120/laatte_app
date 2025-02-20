import 'package:hive_flutter/hive_flutter.dart';
import 'package:laatte/common_libs.dart';

class Storage {
  static late Box _box;

  /// Initialize Hive storage
  static Future<void> init() async {
    _box = await Hive.openBox(Constants.storageBox);
  }

  /// Set a value in the storage
  static Future<void> set<T>(String key, T value) async {
    await _box.put(key, value);
  }

  /// Get a value from the storage
  static T? get<T>(String key, {T? defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  }

  /// Remove a value from the storage
  static Future<void> remove(String key) async {
    await _box.delete(key);
  }

  /// Clear all stored values
  static Future<void> clear() async {
    await _box.clear();
  }

  /// Check if a key exists
  static bool containsKey(String key) {
    return _box.containsKey(key);
  }
}
