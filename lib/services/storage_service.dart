import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service xử lý local storage
class StorageService extends GetxService {
  late final SharedPreferences _prefs;

  /// Key constants cho SharedPreferences
  static const String keyTheme = 'theme';
  static const String keyToken = 'token';
  static const String keyUser = 'user';

  /// Khởi tạo StorageService
  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  /// Get value với kiểu String
  String? getString(String key) => _prefs.getString(key);

  /// Set value với kiểu String
  Future<bool> setString(String key, String value) =>
      _prefs.setString(key, value);

  /// Get value với kiểu bool
  bool? getBool(String key) => _prefs.getBool(key);

  /// Set value với kiểu bool
  Future<bool> setBool(String key, bool value) => _prefs.setBool(key, value);

  /// Get value với kiểu int
  int? getInt(String key) => _prefs.getInt(key);

  /// Set value với kiểu int
  Future<bool> setInt(String key, int value) => _prefs.setInt(key, value);

  /// Get value với kiểu double
  double? getDouble(String key) => _prefs.getDouble(key);

  /// Set value với kiểu double
  Future<bool> setDouble(String key, double value) =>
      _prefs.setDouble(key, value);

  /// Xóa value theo key
  Future<bool> remove(String key) => _prefs.remove(key);

  /// Xóa tất cả data
  Future<bool> clear() => _prefs.clear();

  /// Check key tồn tại
  bool hasKey(String key) => _prefs.containsKey(key);
}
