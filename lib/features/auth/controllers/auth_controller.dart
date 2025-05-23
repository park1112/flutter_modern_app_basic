import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/constants/app_strings.dart';

class AuthController extends GetxController {
  final _storage = GetStorage();
  // final _supabase = Supabase.instance.client;
  
  // Observable states
  final isLoading = false.obs;
  final showPassword = false.obs;
  final rememberMe = false.obs;
  
  // Register form states
  final currentStep = 0.obs;
  final formData = <String, dynamic>{}.obs;
  
  // Terms agreement states
  final agreeAll = false.obs;
  final agreeTerms = false.obs;
  final agreePrivacy = false.obs;
  final agreeMarketing = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    // Load saved remember me preference
    rememberMe.value = _storage.read<bool>(AppConstants.rememberMeKey) ?? false;
  }
  
  void togglePasswordVisibility() {
    showPassword.value = !showPassword.value;
  }
  
  // Register step navigation
  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }
  
  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }
  
  void updateFormData(Map<String, dynamic> data) {
    formData.addAll(data);
  }
  
  void setAgreeAll(bool value) {
    agreeAll.value = value;
    agreeTerms.value = value;
    agreePrivacy.value = value;
    agreeMarketing.value = value;
  }
  
  // Login method
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;
      
      // Save remember me preference
      await _storage.write(AppConstants.rememberMeKey, rememberMe.value);
      
      // TODO: Supabase 설정 후 주석 해제
      // Attempt to sign in
      // final response = await _supabase.auth.signInWithPassword(
      //   email: email,
      //   password: password,
      // );
      // 
      // if (response.user != null) {
      //   // Save user data
      //   await _storage.write(AppConstants.userDataKey, response.user!.toJson());
      //   
      //   // Show success message
      //   Fluttertoast.showToast(msg: AppStrings.loginSuccess);
      //   
      //   // Navigate to main app
      //   Get.offAllNamed(AppRoutes.main);
      // }
      
      // 임시 로그인 처리
      if (email == 'test@test.com' && password == 'password') {
        await _storage.write(AppConstants.userDataKey, {'email': email});
        Fluttertoast.showToast(msg: AppStrings.loginSuccess);
        Get.offAllNamed(AppRoutes.main);
      } else {
        throw Exception('이메일 또는 비밀번호가 일치하지 않습니다.');
      }
    // } on AuthException catch (e) {
    //   // Handle auth specific errors
    //   String errorMessage = AppStrings.loginFailed;
    //   
    //   switch (e.message) {
    //     case 'Invalid login credentials':
    //       errorMessage = '이메일 또는 비밀번호가 일치하지 않습니다.';
    //       break;
    //     case 'Email not confirmed':
    //       errorMessage = '이메일 인증이 필요합니다.';
    //       break;
    //     default:
    //       errorMessage = e.message;
    //   }
    //   
    //   Get.snackbar(
    //     AppStrings.error,
    //     errorMessage,
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    } catch (e) {
      // Handle general errors
      Get.snackbar(
        AppStrings.error,
        AppStrings.networkError,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Register method
  Future<void> register() async {
    try {
      // Validate required terms
      if (!agreeTerms.value || !agreePrivacy.value) {
        Get.snackbar(
          AppStrings.warning,
          '필수 약관에 동의해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      
      isLoading.value = true;
      
      // Prepare user metadata
      final metadata = {
        'name': formData['name'],
        'phone_number': formData['phoneNumber'],
        'company_name': formData['companyName'],
        'business_number': formData['businessNumber'],
        'user_type': formData['userType'],
        'marketing_agreed': agreeMarketing.value,
      };
      
      // TODO: Supabase 설정 후 주석 해제
      // Create user account
      // final response = await _supabase.auth.signUp(
      //   email: formData['email'],
      //   password: formData['password'],
      //   data: metadata,
      // );
      // 
      // if (response.user != null) {
      //   // Show success message
      //   Fluttertoast.showToast(msg: AppStrings.registerSuccess);
      //   
      //   // Navigate to login
      //   Get.offAllNamed(AppRoutes.login);
      //   
      //   // Show email verification message
      //   Get.snackbar(
      //     '회원가입 완료',
      //     '이메일로 전송된 인증 링크를 확인해주세요.',
      //     snackPosition: SnackPosition.BOTTOM,
      //     duration: const Duration(seconds: 5),
      //   );
      // }
      
      // 임시 회원가입 처리
      Fluttertoast.showToast(msg: AppStrings.registerSuccess);
      Get.offAllNamed(AppRoutes.login);
      Get.snackbar(
        '회원가입 완료',
        '로그인 화면에서 test@test.com / password로 로그인해주세요.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    // } on AuthException catch (e) {
    //   // Handle auth specific errors
    //   String errorMessage = AppStrings.registerFailed;
    //   
    //   switch (e.message) {
    //     case 'User already registered':
    //       errorMessage = '이미 등록된 이메일입니다.';
    //       break;
    //     default:
    //       errorMessage = e.message;
    //   }
    //   
    //   Get.snackbar(
    //     AppStrings.error,
    //     errorMessage,
    //     snackPosition: SnackPosition.BOTTOM,
    //   );
    } catch (e) {
      // Handle general errors
      Get.snackbar(
        AppStrings.error,
        AppStrings.networkError,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Logout method
  Future<void> logout() async {
    try {
      isLoading.value = true;
      
      // TODO: Supabase 설정 후 주석 해제
      // await _supabase.auth.signOut();
      
      // Clear stored data
      await _storage.remove(AppConstants.userDataKey);
      
      // Show success message
      Fluttertoast.showToast(msg: AppStrings.logoutSuccess);
      
      // Navigate to login
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar(
        AppStrings.error,
        '로그아웃 중 오류가 발생했습니다.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
