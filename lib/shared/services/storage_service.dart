import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_agroflow/core/constants/app_constants.dart';

class StorageService extends GetxService {
  late GetStorage _box;

  Future<StorageService> init() async {
    await GetStorage.init();
    _box = GetStorage();
    return this;
  }

  // Auth Token
  Future<void> saveAuthToken(String token) async {
    await _box.write(AppConstants.authTokenKey, token);
  }

  String? getAuthToken() {
    return _box.read<String>(AppConstants.authTokenKey);
  }

  Future<bool> hasAuthToken() async {
    final token = getAuthToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> removeAuthToken() async {
    await _box.remove(AppConstants.authTokenKey);
  }

  // User Data
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    await _box.write(AppConstants.userDataKey, userData);
  }

  Map<String, dynamic>? getUserData() {
    return _box.read<Map<String, dynamic>>(AppConstants.userDataKey);
  }

  Future<void> removeUserData() async {
    await _box.remove(AppConstants.userDataKey);
  }

  // Remember Me
  Future<void> setRememberMe(bool value) async {
    await _box.write(AppConstants.rememberMeKey, value);
  }

  bool getRememberMe() {
    return _box.read<bool>(AppConstants.rememberMeKey) ?? false;
  }

  // Language
  Future<void> setLanguage(String language) async {
    await _box.write(AppConstants.languageKey, language);
  }

  String getLanguage() {
    return _box.read<String>(AppConstants.languageKey) ?? 'ko';
  }

  // Theme
  Future<void> setTheme(String theme) async {
    await _box.write(AppConstants.themeKey, theme);
  }

  String getTheme() {
    return _box.read<String>(AppConstants.themeKey) ?? 'light';
  }

  // Clear All Data
  Future<void> clearAll() async {
    await _box.erase();
  }

  // Clear Auth Data
  Future<void> clearAuthData() async {
    await removeAuthToken();
    await removeUserData();
  }
}
