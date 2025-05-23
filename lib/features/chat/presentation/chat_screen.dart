import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../controllers/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.find();

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
          // Modern App Bar
          SliverAppBar(
            expandedHeight: size.height * 0.15,
            floating: true,
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
                    colors: [AppColors.accent, AppColors.accentLight],
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppStrings.chat,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium
                                      ?.copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Obx(
                                  () => Text(
                                    '${controller.chatRooms.length}개의 대화',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: AppColors.white.withOpacity(
                                            0.9,
                                          ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.search_rounded,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    _showSearchDialog(context);
                                  },
                                ),
                                IconButton(
                                  icon: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: const Icon(
                                      Icons.more_vert_rounded,
                                      color: AppColors.white,
                                    ),
                                  ),
                                  onPressed: () {
                                    _showMoreOptions(context);
                                  },
                                ),
                              ],
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

          // Chat List
          Obx(() {
            if (controller.chatRooms.isEmpty) {
              return SliverFillRemaining(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          gradient: AppColors.accentGradient,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.chat_bubble_outline_rounded,
                          size: 64,
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        '아직 대화가 없습니다',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '거래처와 대화를 시작해보세요',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () {
                          Get.snackbar(
                            '준비 중',
                            '새 대화 시작 기능은 준비 중입니다.',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppColors.grey900,
                            colorText: AppColors.white,
                            borderRadius: 12,
                            margin: const EdgeInsets.all(16),
                          );
                        },
                        icon: const Icon(Icons.add_rounded),
                        label: const Text('새 대화 시작'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final chatRoom = controller.chatRooms[index];
                  return _buildChatItem(context, chatRoom, index);
                }, childCount: controller.chatRooms.length),
              ),
            );
          }),
        ],
      ),
      floatingActionButton: Obx(() {
        if (controller.chatRooms.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.accent.withOpacity(0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: FloatingActionButton.extended(
            onPressed: () {
              Get.snackbar(
                '준비 중',
                '새 대화 시작 기능은 준비 중입니다.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: AppColors.grey900,
                colorText: AppColors.white,
                borderRadius: 12,
                margin: const EdgeInsets.all(16),
              );
            },
            backgroundColor: AppColors.accent,
            icon: const Icon(Icons.edit_rounded),
            label: const Text(
              '새 대화',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildChatItem(
    BuildContext context,
    Map<String, dynamic> chatRoom,
    int index,
  ) {
    final bool hasUnread = chatRoom['unreadCount'] > 0;
    final bool isOnline = index % 3 == 0; // Sample online status

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasUnread
              ? AppColors.accent.withOpacity(0.3)
              : AppColors.grey200,
          width: hasUnread ? 2 : 1,
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: hasUnread
        //         ? AppColors.accent.withOpacity(0.1)
        //         : AppColors.shadowLight,
        //     blurRadius: hasUnread ? 16 : 8,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Get.snackbar(
              '준비 중',
              '채팅 기능은 준비 중입니다.',
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: AppColors.grey900,
              colorText: AppColors.white,
              borderRadius: 12,
              margin: const EdgeInsets.all(16),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Avatar with online indicator
                Stack(
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [AppColors.accentLight, AppColors.accent],
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          chatRoom['name']![0],
                          style: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    if (isOnline)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.surface,
                              width: 3,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),

                // Chat info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chatRoom['name']!,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                            ),
                          ),
                          Text(
                            chatRoom['time']!,
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: hasUnread
                                      ? AppColors.accent
                                      : AppColors.textTertiary,
                                  fontWeight: hasUnread
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chatRoom['lastMessage']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(
                                    color: hasUnread
                                        ? AppColors.textPrimary
                                        : AppColors.textSecondary,
                                    fontWeight: hasUnread
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                            ),
                          ),
                          if (hasUnread) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppColors.accentGradient,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${chatRoom['unreadCount']}',
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '대화 검색',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: '검색어를 입력하세요',
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: AppColors.grey50,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                '검색 기능은 준비 중입니다.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('닫기'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
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
                  children: [
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.primarySurface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.mark_chat_read_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      title: const Text('모두 읽음으로 표시'),
                      subtitle: const Text('모든 대화를 읽음 처리합니다'),
                      onTap: () {
                        Navigator.pop(context);
                        Get.snackbar(
                          '완료',
                          '모든 대화를 읽음으로 표시했습니다.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.grey900,
                          colorText: AppColors.white,
                          borderRadius: 12,
                          margin: const EdgeInsets.all(16),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.accentSurface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.archive_rounded,
                          color: AppColors.accent,
                        ),
                      ),
                      title: const Text('보관된 대화'),
                      subtitle: const Text('보관함으로 이동한 대화 보기'),
                      onTap: () {
                        Navigator.pop(context);
                        Get.snackbar(
                          '준비 중',
                          '보관함 기능은 준비 중입니다.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.grey900,
                          colorText: AppColors.white,
                          borderRadius: 12,
                          margin: const EdgeInsets.all(16),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.warningSurface,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.settings_rounded,
                          color: AppColors.warning,
                        ),
                      ),
                      title: const Text('채팅 설정'),
                      subtitle: const Text('알림 및 기타 설정 변경'),
                      onTap: () {
                        Navigator.pop(context);
                        Get.snackbar(
                          '준비 중',
                          '채팅 설정 기능은 준비 중입니다.',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
