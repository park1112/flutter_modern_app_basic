import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../controllers/menu_controller.dart' as menu;

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final menuController = Get.find<menu.MenuController>();

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
            expandedHeight: size.height * 0.18,
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
                    colors: [AppColors.primaryLight, AppColors.primary],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          AppStrings.menu,
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '필요한 기능을 선택해주세요',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppColors.white.withOpacity(0.9),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: IconButton(
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
              ),
            ],
          ),

          // Search Bar
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () => _showSearchDialog(context),
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.grey200, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadowLight,
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.search_rounded, color: AppColors.grey500),
                    const SizedBox(width: 12),
                    Text(
                      '메뉴 검색',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Menu Categories
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildModernMenuSection(
                  context,
                  title: AppStrings.customerManagementFull,
                  subtitle: '거래처 정보를 효율적으로 관리하세요',
                  icon: Icons.people_rounded,
                  gradient: AppColors.primaryGradient,
                  items: [
                    _MenuItemData('거래처 목록', Icons.list_rounded, '전체 거래처 조회'),
                    _MenuItemData(
                      '거래처 등록',
                      Icons.person_add_rounded,
                      '새 거래처 추가',
                    ),
                    _MenuItemData(
                      '거래처 분석',
                      Icons.analytics_rounded,
                      '거래 현황 분석',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _buildModernMenuSection(
                  context,
                  title: AppStrings.productManagement,
                  subtitle: '상품 정보와 가격을 관리하세요',
                  icon: Icons.inventory_2_rounded,
                  color: AppColors.accent,
                  items: [
                    _MenuItemData('상품 목록', Icons.grid_view_rounded, '전체 상품 조회'),
                    _MenuItemData('상품 등록', Icons.add_box_rounded, '새 상품 추가'),
                    _MenuItemData(
                      '가격 관리',
                      Icons.attach_money_rounded,
                      '가격 정책 설정',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _buildModernMenuSection(
                  context,
                  title: AppStrings.orderSales,
                  subtitle: '주문 접수부터 배송까지 관리하세요',
                  icon: Icons.shopping_cart_rounded,
                  gradient: AppColors.accentGradient,
                  items: [
                    _MenuItemData(
                      '주문 접수',
                      Icons.add_shopping_cart_rounded,
                      '새 주문 등록',
                    ),
                    _MenuItemData(
                      '주문 현황',
                      Icons.receipt_long_rounded,
                      '주문 내역 확인',
                    ),
                    _MenuItemData(
                      '배송 관리',
                      Icons.local_shipping_rounded,
                      '배송 상태 추적',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _buildModernMenuSection(
                  context,
                  title: AppStrings.inventoryManagement,
                  subtitle: '재고를 실시간으로 관리하세요',
                  icon: Icons.warehouse_rounded,
                  color: AppColors.warning,
                  items: [
                    _MenuItemData(
                      '재고 현황',
                      Icons.inventory_rounded,
                      '실시간 재고 확인',
                    ),
                    _MenuItemData(
                      '입출고 관리',
                      Icons.swap_horiz_rounded,
                      '입출고 내역 관리',
                    ),
                    _MenuItemData('재고 조정', Icons.tune_rounded, '재고 수량 조정'),
                  ],
                ),
                const SizedBox(height: 16),

                _buildModernMenuSection(
                  context,
                  title: AppStrings.settlementManagementFull,
                  subtitle: '매입과 매출을 정확하게 정산하세요',
                  icon: Icons.calculate_rounded,
                  color: AppColors.success,
                  items: [
                    _MenuItemData('매입 정산', Icons.receipt_rounded, '매입 내역 정산'),
                    _MenuItemData(
                      '매출 정산',
                      Icons.point_of_sale_rounded,
                      '매출 내역 정산',
                    ),
                    _MenuItemData(
                      '미수금 관리',
                      Icons.account_balance_wallet_rounded,
                      '미수금 현황',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _buildModernMenuSection(
                  context,
                  title: AppStrings.contractManagement,
                  subtitle: '계약 정보를 체계적으로 관리하세요',
                  icon: Icons.description_rounded,
                  color: AppColors.info,
                  items: [
                    _MenuItemData('계약 목록', Icons.list_alt_rounded, '전체 계약 조회'),
                    _MenuItemData('계약 등록', Icons.note_add_rounded, '새 계약 추가'),
                    _MenuItemData(
                      '계약 만료 알림',
                      Icons.notifications_rounded,
                      '만료 예정 계약',
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                _buildModernMenuSection(
                  context,
                  title: AppStrings.logisticsManagement,
                  subtitle: '물류 기기를 효율적으로 관리하세요',
                  icon: Icons.warehouse_rounded,
                  color: AppColors.secondary,
                  items: [
                    _MenuItemData('기기 목록', Icons.devices_rounded, '전체 기기 조회'),
                    _MenuItemData('기기 등록', Icons.add_circle_rounded, '새 기기 추가'),
                    _MenuItemData('유지보수 관리', Icons.build_rounded, '정기 점검 관리'),
                  ],
                ),
                const SizedBox(height: 16),

                _buildModernMenuSection(
                  context,
                  title: AppStrings.reports,
                  subtitle: '다양한 보고서를 확인하세요',
                  icon: Icons.assessment_rounded,
                  gradient: LinearGradient(
                    colors: [AppColors.chart5, AppColors.chart8],
                  ),
                  items: [
                    _MenuItemData(
                      '매출 보고서',
                      Icons.trending_up_rounded,
                      '매출 분석 리포트',
                    ),
                    _MenuItemData(
                      '재고 보고서',
                      Icons.bar_chart_rounded,
                      '재고 현황 리포트',
                    ),
                    _MenuItemData(
                      '거래처 보고서',
                      Icons.pie_chart_rounded,
                      '거래처 분석 리포트',
                    ),
                  ],
                ),
                SizedBox(height: padding.bottom + 100),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernMenuSection(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    LinearGradient? gradient,
    Color? color,
    required List<_MenuItemData> items,
  }) {
    final isExpanded = ValueNotifier<bool>(false);

    return ValueListenableBuilder<bool>(
      valueListenable: isExpanded,
      builder: (context, expanded, child) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: expanded
                  ? (gradient != null
                            ? AppColors.primary
                            : color ?? AppColors.grey300)
                        .withOpacity(0.3)
                  : AppColors.grey200,
              width: expanded ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: expanded
                    ? (gradient != null
                              ? AppColors.primary
                              : color ?? AppColors.grey400)
                          .withOpacity(0.1)
                    : AppColors.shadowLight,
                blurRadius: expanded ? 20 : 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ExpansionTile(
            onExpansionChanged: (value) => isExpanded.value = value,
            tilePadding: const EdgeInsets.all(20),
            childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            leading: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: gradient,
                color: gradient == null ? color?.withOpacity(0.1) : null,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                icon,
                color: gradient != null ? AppColors.white : color,
                size: 28,
              ),
            ),
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            subtitle: Text(
              subtitle,
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
            trailing: AnimatedRotation(
              turns: expanded ? 0.5 : 0,
              duration: const Duration(milliseconds: 300),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: expanded
                      ? (gradient != null
                            ? AppColors.primarySurface
                            : color?.withOpacity(0.1) ?? AppColors.grey100)
                      : AppColors.grey100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.expand_more_rounded,
                  color: expanded
                      ? (gradient != null
                            ? AppColors.primary
                            : color ?? AppColors.grey600)
                      : AppColors.grey600,
                ),
              ),
            ),
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;

              return AnimatedContainer(
                duration: Duration(milliseconds: 300 + (index * 100)),
                curve: Curves.easeOutBack,
                margin: const EdgeInsets.only(bottom: 8),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.snackbar(
                        '준비 중',
                        '${item.title} 기능은 준비 중입니다.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.grey900,
                        colorText: AppColors.white,
                        borderRadius: 12,
                        margin: const EdgeInsets.all(16),
                      );
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.grey50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.grey200, width: 1),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              item.icon,
                              color: gradient != null
                                  ? AppColors.primary
                                  : color ?? AppColors.grey600,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: Theme.of(context).textTheme.titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.description,
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                      ),
                                ),
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
                ),
              );
            }).toList(),
          ),
        );
      },
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
                '메뉴 검색',
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
}

class _MenuItemData {
  final String title;
  final IconData icon;
  final String description;

  _MenuItemData(this.title, this.icon, this.description);
}
