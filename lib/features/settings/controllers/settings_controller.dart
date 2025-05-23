import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final _storage = GetStorage();
  
  // User info
  final userName = '홍길동'.obs;
  final userEmail = 'hong@example.com'.obs;
  final userType = 'supplier'.obs;
  
  // Notification settings
  final orderNotification = true.obs;
  final settlementNotification = true.obs;
  final chatNotification = true.obs;
  
  // Security settings
  final biometricEnabled = false.obs;
  final autoLogoutTime = 15.obs; // minutes
  
  @override
  void onInit() {
    super.onInit();
    loadSettings();
  }
  
  void loadSettings() {
    // TODO: Load actual user info from Supabase
    // Load notification settings from storage
    orderNotification.value = _storage.read('orderNotification') ?? true;
    settlementNotification.value = _storage.read('settlementNotification') ?? true;
    chatNotification.value = _storage.read('chatNotification') ?? true;
    biometricEnabled.value = _storage.read('biometricEnabled') ?? false;
  }
  
  Future<void> saveSettings() async {
    await _storage.write('orderNotification', orderNotification.value);
    await _storage.write('settlementNotification', settlementNotification.value);
    await _storage.write('chatNotification', chatNotification.value);
    await _storage.write('biometricEnabled', biometricEnabled.value);
  }
  
  Future<void> clearCache() async {
    // TODO: Implement cache clearing
    await Future.delayed(const Duration(seconds: 1));
  }
  
  @override
  void onClose() {
    saveSettings();
    super.onClose();
  }
}
