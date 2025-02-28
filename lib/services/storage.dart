import 'package:hive_flutter/hive_flutter.dart';

import '../utils/constants.dart';

class Storage {
  static Box? _box;

  /// Initialize Hive storage
  static Future<void> init() async {
    if (_box == null || !_box!.isOpen) {
      _box = await Hive.openBox(Constants.storageBox);
    }
  }

  static Future<void> set<T>(String key, T value) async {
    await init(); // Ensure it's initialized
    await _box!.put(key, value);
  }

  static T? get<T>(String key, {T? defaultValue}) {
    return _box?.get(key, defaultValue: defaultValue);
  }

  static Future<void> remove(String key) async {
    await init();
    await _box!.delete(key);
  }

  static Future<void> clear() async {
    await init();
    await _box!.clear();
  }

  static bool containsKey(String key) {
    return _box?.containsKey(key) ?? false;
  }

  Stream<dynamic> watch(String key) {
    return _box!.watch(key: key).map((event) => event.value);
  }
}
