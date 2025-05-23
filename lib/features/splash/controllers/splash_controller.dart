import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/constants/app_constants.dart';

class SplashController extends GetxController {
  final _storage = GetStorage();
  // final _supabase = Supabase.instance.client;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> checkAuthStatus() async {
    await Future.delayed(AppConstants.splashDuration);
    
    try {
      // Check if user has saved credentials
      final rememberMe = _storage.read<bool>(AppConstants.rememberMeKey) ?? false;
      
      if (rememberMe) {
        // TODO: Supabase 설정 후 주석 해제
        // Check if there's a valid session
        // final session = _supabase.auth.currentSession;
        // 
        // if (session != null) {
        //   // Session exists, check if it's still valid
        //   final user = _supabase.auth.currentUser;
        //   
        //   if (user != null) {
        //     // Valid session, go to main app
        //     Get.offAllNamed(AppRoutes.main);
        //     return;
        //   }
        // }
      }
      
      // No valid session, go to login
      Get.offAllNamed(AppRoutes.login);
      
    } catch (e) {
      // Error occurred, go to login
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
