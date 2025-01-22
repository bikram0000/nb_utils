import 'dart:convert';

import 'package:nb_utils/nb_utils.dart';
import 'package:get_storage/get_storage.dart';

final GetStorage storage = GetStorage();

/// Initialize GetStorage
Future<void> initStorage() async {
  await GetStorage.init();
}

/// Add a value to GetStorage based on its type (supports String, int, bool, double, Map<String, dynamic>, StringList)
Future<bool> setValue(String key, dynamic value, {bool print = true}) async {
  if (value == null) {
    if (print) log('$key - value is null');
    return Future.value(false);
  }
  if (print) log('${value.runtimeType} - $key - $value');

  if (value is String) {
    storage.write(key, value);
  } else if (value is int) {
    storage.write(key, value);
  } else if (value is bool) {
    storage.write(key, value);
  } else if (value is double) {
    storage.write(key, value);
  } else if (value is Map<String, dynamic>) {
    storage.write(key, jsonEncode(value));
  } else if (value is List<String>) {
    storage.write(key, value);
  } else {
    throw ArgumentError(
      'Invalid value ${value.runtimeType} - Must be a String, int, bool, double, Map<String, dynamic> or StringList');
  }
  return true;
}

/// Returns List of Keys that match the given key (GetStorage does not have a direct equivalent for this)
List<String> getMatchingStorageKeys(String key) {
  List<String> keys = [];
  // In GetStorage, you would need to manually check keys, as GetStorage does not have `getKeys` method
  storage.getKeys().forEach((element) {
    if (element.contains(key)) {
      keys.add(element);
    }
  });
  return keys;
}

/// Returns a StringList if exists in GetStorage
List<String>? getStringListAsync(String key) {
  return storage.read<List<String>>(key);
}

/// Returns a Bool if exists in GetStorage
bool getBoolAsync(String key, {bool defaultValue = false}) {
  return storage.read<bool>(key) ?? defaultValue;
}

/// Returns a Double if exists in GetStorage
double getDoubleAsync(String key, {double defaultValue = 0.0}) {
  return storage.read<double>(key) ?? defaultValue;
}

/// Returns an Int if exists in GetStorage
int getIntAsync(String key, {int defaultValue = 0}) {
  return storage.read<int>(key) ?? defaultValue;
}

/// Returns a String if exists in GetStorage
String getStringAsync(String key, {String defaultValue = ''}) {
  return storage.read<String>(key) ?? defaultValue;
}

/// Returns a JSON (Map<String, dynamic>) if exists in GetStorage
Map<String, dynamic> getJSONAsync(String key, {Map<String, dynamic>? defaultValue}) {
  String? jsonString = storage.read<String>(key);
  if (jsonString != null && jsonString.isNotEmpty) {
    return jsonDecode(jsonString);
  } else {
    return defaultValue ?? {};
  }
}

/// Remove key from GetStorage
Future<bool> removeKey(String key) async {
  await storage.remove(key);
  return true;
}

/// Clear GetStorage
Future<bool> clearStorage() async {
  await storage.erase();
  return true;
}

/////////////////////////////////////////////////////////////////////// DEPRECATED \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\

/// Deprecated methods, use `setValue` and `get*Async` methods instead

@Deprecated('Use setValue instead')
Future<bool> setDoubleAsync(String key, double value) async {
  storage.write(key, value);
  return true;
}

@Deprecated('Use setValue instead')
Future<bool> setBoolAsync(String key, bool value) async {
  storage.write(key, value);
  return true;
}

@Deprecated('Use setValue instead')
Future<bool> setIntAsync(String key, int value) async {
  storage.write(key, value);
  return true;
}

@Deprecated('Use setValue instead')
Future<bool> setStringAsync(String key, String value) async {
  storage.write(key, value);
  return true;
}

@Deprecated('Use setValue instead')
Future<bool> setJSONAsync(String key, String value) async {
  storage.write(key, jsonEncode(value));
  return true;
}

@Deprecated('Use getStringAsync instead without using await')
Future<String> getString(String key, {defaultValue = ''}) async {
  return storage.read<String>(key) ?? defaultValue;
}

@Deprecated('Use getIntAsync instead without using await')
Future<int> getInt(String key, {defaultValue = 0}) async {
  return storage.read<int>(key) ?? defaultValue;
}

@Deprecated('Use getDoubleAsync instead without using await')
Future<double> getDouble(String key, {defaultValue = 0.0}) async {
  return storage.read<double>(key) ?? defaultValue;
}

@Deprecated('Use getBoolAsync instead without using await')
Future<bool> getBool(String key, {defaultValue = false}) async {
  return storage.read<bool>(key) ?? defaultValue;
}

@Deprecated('Use setValue instead')
Future<bool> setString(String key, String value) async {
  storage.write(key, value);
  return true;
}

@Deprecated('Use setValue instead')
Future<bool> setInt(String key, int value) async {
  storage.write(key, value);
  return true;
}

@Deprecated('Use setValue instead')
Future<bool> setBool(String key, bool value) async {
  storage.write(key, value);
  return true;
}

@Deprecated('Use setValue instead')
Future<bool> setDouble(String key, double value) async {
  storage.write(key, value);
  return true;
}
