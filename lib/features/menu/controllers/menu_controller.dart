import 'package:get/get.dart';

class MenuController extends GetxController {
  // Search query
  final searchQuery = ''.obs;
  
  // Favorite menu items
  final favoriteMenus = <String>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }
  
  void loadFavorites() {
    // TODO: Load favorites from storage
    favoriteMenus.value = ['거래처 목록', '주문 접수', '재고 현황'];
  }
  
  void toggleFavorite(String menuItem) {
    if (favoriteMenus.contains(menuItem)) {
      favoriteMenus.remove(menuItem);
    } else {
      favoriteMenus.add(menuItem);
    }
    // TODO: Save to storage
  }
  
  bool isFavorite(String menuItem) {
    return favoriteMenus.contains(menuItem);
  }
}
