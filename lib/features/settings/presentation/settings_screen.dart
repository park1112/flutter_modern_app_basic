import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../controllers/settings_controller.dart';
import '../../auth/controllers/auth_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.find();
    final AuthController authController = Get.put(AuthController());
    
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Modern App Bar with Profile
          SliverAppBar(
            expandedHeight: size.height * 0.25,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: AppColors.surface,
            automaticallyImplyLeading: false,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary,
                      AppColors.primaryLight,
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            // Profile Avatar
                            Stack(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.white.withOpacity(0.3),
                                        AppColors.white.withOpacity(0.1),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: AppColors.white.withOpacity(0.5),
                                      width: 3,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.person_rounded,
                                    size: 40,
                                    color: AppColors.white,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppColors.shadowMedium,
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.camera_alt_rounded,
                                      size: 16,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(() => Text(
                                    controller.userName.value,
                                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                                  const SizedBox(height: 4),
                                  Obx(() => Text(
                                    controller.userEmail.value,
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: AppColors.white.withOpacity(0.9),
                                    ),
                                  )),
                                  const SizedBox(height: 8),
                                  Obx(() => Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      controller.userType.value == 'supplier'
                                          ? AppStrings.supplier
                                          : AppStrings.buyer,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.edit_rounded,
                                  color: AppColors.white,
                                  size: 20,
                                ),
                              ),
                              onPressed: () {
                                Get.snackbar(
                                  '준비 중',
                                  '프로필 수정 기능은 준비 중입니다.',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppColors.grey900,
                                  colorText: AppColors.white,
                                  borderRadius: 12,
                                  margin: const EdgeInsets.all(16),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Settings Content
          SliverToBoxAdapter(
            child: Column(
              children: [
                const SizedBox(height: 20),
                
                // Notification Settings
                _buildModernSettingsSection(
                  context,
                  title: '알림 설정',
                  icon: Icons.notifications_rounded,
                  iconColor: AppColors.primary,
                  children: [
                    _buildModernSwitchTile(
                      context,
                      icon: Icons.shopping_cart_rounded,
                      iconColor: AppColors.info,
                      title: '주문 알림',
                      subtitle: '새로운 주문이 들어올 때 알림',
                      value: controller.orderNotification,
                      onChanged: (value) {
                        controller.orderNotification.value = value;
                      },
                    ),
                    _buildModernSwitchTile(
                      context,
                      icon: Icons.calculate_rounded,
                      iconColor: AppColors.success,
                      title: '정산 알림',
                      subtitle: '정산 완료 시 알림',
                      value: controller.settlementNotification,
                      onChanged: (value) {
                        controller.settlementNotification.value = value;
                      },
                    ),
                    _buildModernSwitchTile(
                      context,
                      icon: Icons.chat_rounded,
                      iconColor: AppColors.accent,
                      title: '채팅 알림',
                      subtitle: '새로운 메시지 알림',
                      value: controller.chatNotification,
                      onChanged: (value) {
                        controller.chatNotification.value = value;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Security Settings
                _buildModernSettingsSection(
                  context,
                  title: '보안 설정',
                  icon: Icons.security_rounded,
                  iconColor: AppColors.error,
                  children: [
                    _buildModernListTile(
                      context,
                      icon: Icons.lock_rounded,
                      iconColor: AppColors.error,
                      title: AppStrings.changePassword,
                      onTap: () {
                        Get.snackbar(
                          '준비 중',
                          '비밀번호 변경 기능은 준비 중입니다.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.grey900,
                          colorText: AppColors.white,
                          borderRadius: 12,
                          margin: const EdgeInsets.all(16),
                        );
                      },
                    ),
                    _buildModernSwitchTile(
                      context,
                      icon: Icons.fingerprint_rounded,
                      iconColor: AppColors.secondary,
                      title: AppStrings.biometricAuth,
                      subtitle: '생체 인증으로 로그인',
                      value: controller.biometricEnabled,
                      onChanged: (value) {
                        controller.biometricEnabled.value = value;
                      },
                    ),
                    _buildModernListTile(
                      context,
                      icon: Icons.timer_rounded,
                      iconColor: AppColors.warning,
                      title: AppStrings.autoLogout,
                      subtitle: '15분',
                      onTap: () {
                        _showAutoLogoutOptions(context);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // Data Management
                _buildModernSettingsSection(
                  context,
                  title: '데이터 관리',
                  icon: Icons.storage_rounded,
                  iconColor: AppColors.info,
                  children: [
                    _buildModernListTile(
                      context,
                      icon: Icons.cleaning_services_rounded,
                      iconColor: AppColors.warning,
                      title: AppStrings.clearCache,
                      subtitle: '캐시된 데이터 삭제',
                      onTap: () async {
                        _showClearCacheDialog(context, controller);
                      },
                    ),
                    _buildModernListTile(
                      context,
                      icon: Icons.backup_rounded,
                      iconColor: AppColors.success,
                      title: AppStrings.backup,
                      subtitle: '데이터 백업하기',
                      onTap: () {
                        Get.snackbar(
                          '준비 중',
                          '백업 기능은 준비 중입니다.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.grey900,
                          colorText: AppColors.white,
                          borderRadius: 12,
                          margin: const EdgeInsets.all(16),
                        );
                      },
                    ),
                    _buildModernListTile(
                      context,
                      icon: Icons.restore_rounded,
                      iconColor: AppColors.info,
                      title: AppStrings.restore,
                      subtitle: '백업 데이터 복원',
                      onTap: () {
                        Get.snackbar(
                          '준비 중',
                          '복원 기능은 준비 중입니다.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.grey900,
                          colorText: AppColors.white,
                          borderRadius: 12,
                          margin: const EdgeInsets.all(16),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                
                // App Info
                _buildModernSettingsSection(
                  context,
                  title: '앱 정보',
                  icon: Icons.info_rounded,
                  iconColor: AppColors.accent,
                  children: [
                    _buildModernListTile(
                      context,
                      icon: Icons.info_outline_rounded,
                      iconColor: AppColors.accent,
                      title: AppStrings.version,
                      subtitle: AppConstants.appVersion,
                      onTap: () {
                        _showVersionInfo(context);
                      },
                    ),
                    _buildModernListTile(
                      context,
                      icon: Icons.description_rounded,
                      iconColor: AppColors.primary,
                      title: AppStrings.termsOfService,
                      onTap: () {},
                    ),
                    _buildModernListTile(
                      context,
                      icon: Icons.privacy_tip_rounded,
                      iconColor: AppColors.secondary,
                      title: AppStrings.privacyPolicy,
                      onTap: () {},
                    ),
                    _buildModernListTile(
                      context,
                      icon: Icons.code_rounded,
                      iconColor: AppColors.chart5,
                      title: AppStrings.openSourceLicenses,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Logout Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.error,
                          AppColors.errorDark,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.error.withOpacity(0.3),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _showLogoutDialog(context, authController),
                        borderRadius: BorderRadius.circular(16),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.logout_rounded,
                                color: AppColors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                AppStrings.logout,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: padding.bottom + 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernSettingsSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color iconColor,
    required List<Widget> children,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          ...children,
        ],
      ),
    );
  }

  Widget _buildModernListTile(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: AppColors.grey400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernSwitchTile(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required RxBool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          Obx(() => Switch(
            value: value.value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          )),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, AuthController authController) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.errorSurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_rounded,
                  size: 32,
                  color: AppColors.error,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '로그아웃',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '정말 로그아웃 하시겠습니까?',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        AppStrings.cancel,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        authController.logout();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        '로그아웃',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearCacheDialog(BuildContext context, SettingsController controller) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.warningSurface,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.cleaning_services_rounded,
                  size: 32,
                  color: AppColors.warning,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '캐시 삭제',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '캐시된 데이터를 삭제하시겠습니까?\n앱 속도가 일시적으로 느려질 수 있습니다.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('취소'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await controller.clearCache();
                        Get.snackbar(
                          '완료',
                          '캐시가 삭제되었습니다.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.grey900,
                          colorText: AppColors.white,
                          borderRadius: 12,
                          margin: const EdgeInsets.all(16),
                        );
                      },
                      child: const Text('삭제'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAutoLogoutOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12),
                decoration: BoxDecoration(
                  color: AppColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '자동 로그아웃 시간',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...[5, 15, 30, 60].map((minutes) => ListTile(
                      title: Text('$minutes분'),
                      trailing: minutes == 15
                          ? Icon(
                              Icons.check_rounded,
                              color: AppColors.primary,
                            )
                          : null,
                      onTap: () {
                        Navigator.pop(context);
                        Get.snackbar(
                          '설정 완료',
                          '자동 로그아웃 시간이 $minutes분으로 설정되었습니다.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.grey900,
                          colorText: AppColors.white,
                          borderRadius: 12,
                          margin: const EdgeInsets.all(16),
                        );
                      },
                    )).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showVersionInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(
                  Icons.eco_rounded,
                  size: 40,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'AgroFlow',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '버전 ${AppConstants.appVersion}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '농산물 유통의 디지털 혁신',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('확인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}