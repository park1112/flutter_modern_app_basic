import 'package:get/get.dart';
import '../controllers/dashboard_controller.dart';
import '../../menu/controllers/menu_controller.dart';
import '../../map/controllers/map_controller.dart';
import '../../chat/controllers/chat_controller.dart';
import '../../settings/controllers/settings_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<MenuController>(() => MenuController());
    Get.lazyPut<MapController>(() => MapController());
    Get.lazyPut<ChatController>(() => ChatController());
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
