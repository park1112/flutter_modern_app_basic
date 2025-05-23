import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_agroflow/core/theme/app_colors.dart';

class AppUtils {
  // Show SnackBar
  static void showSnackBar(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? '오류' : '알림',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? AppColors.error : AppColors.success,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 8,
    );
  }
  
  // Show Toast
  static void showToast(String message, {bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: isError ? AppColors.error : AppColors.textPrimary,
      textColor: Colors.white,
      fontSize: 14,
    );
  }
  
  // Show Loading Dialog
  static void showLoading({String? message}) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              ),
              if (message != null) ...[
                const SizedBox(height: 16),
                Text(
                  message,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
  
  // Hide Loading Dialog
  static void hideLoading() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  
  // Show Confirmation Dialog
  static Future<bool> showConfirmDialog({
    required String title,
    required String message,
    String confirmText = '확인',
    String cancelText = '취소',
  }) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }
  
  // Email Validation
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  // Phone Number Validation
  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^01([0|1|6|7|8|9])([0-9]{3,4})([0-9]{4})$').hasMatch(phone);
  }
  
  // Business Number Validation
  static bool isValidBusinessNumber(String number) {
    return RegExp(r'^\d{3}-\d{2}-\d{5}$').hasMatch(number);
  }
  
  // Format Phone Number
  static String formatPhoneNumber(String phone) {
    if (phone.length == 11) {
      return '${phone.substring(0, 3)}-${phone.substring(3, 7)}-${phone.substring(7)}';
    } else if (phone.length == 10) {
      return '${phone.substring(0, 3)}-${phone.substring(3, 6)}-${phone.substring(6)}';
    }
    return phone;
  }
  
  // Format Currency
  static String formatCurrency(int amount) {
    return '₩${amount.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    )}';
  }
  
  // Format Number
  static String formatNumber(int number) {
    return number.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]},',
    );
  }
  
  // Get Screen Size
  static Size get screenSize => MediaQuery.of(Get.context!).size;
  static double get screenWidth => screenSize.width;
  static double get screenHeight => screenSize.height;
  
  // Check if Tablet
  static bool get isTablet => screenWidth > 600;
  
  // Get Status Bar Height
  static double get statusBarHeight => MediaQuery.of(Get.context!).padding.top;
  
  // Get Bottom Bar Height
  static double get bottomBarHeight => MediaQuery.of(Get.context!).padding.bottom;
}
