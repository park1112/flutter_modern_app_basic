import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_constants.dart';
import '../controllers/map_controller.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController controller = Get.find();
    
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
      body: Stack(
        children: [
          // Map Container - 임시로 Container로 대체
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.grey100,
                  AppColors.grey200,
                ],
              ),
            ),
            child: Stack(
              children: [
                // Placeholder map background
                Positioned.fill(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                      childAspectRatio: 1,
                    ),
                    itemCount: 100,
                    itemBuilder: (context, index) => Container(
                      margin: const EdgeInsets.all(0.5),
                      color: AppColors.white.withOpacity(0.3),
                    ),
                  ),
                ),
                
                // Center placeholder
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadowMedium,
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.map_rounded,
                            size: 48,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Google Maps API 키 설정 필요',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '실제 지도를 표시하려면\nAPI 키를 설정해주세요',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Sample markers
                Positioned(
                  top: size.height * 0.3,
                  left: size.width * 0.2,
                  child: _buildSampleMarker(Icons.store_rounded, AppColors.primary),
                ),
                Positioned(
                  top: size.height * 0.5,
                  right: size.width * 0.3,
                  child: _buildSampleMarker(Icons.warehouse_rounded, AppColors.secondary),
                ),
                Positioned(
                  bottom: size.height * 0.3,
                  left: size.width * 0.4,
                  child: _buildSampleMarker(Icons.local_shipping_rounded, AppColors.info),
                ),
              ],
            ),
          ),
          
          // TODO: Google Maps API 키 설정 후 주석 해제
          // Obx(() => GoogleMap(
          //   initialCameraPosition: CameraPosition(
          //     target: LatLng(
          //       AppConstants.defaultLatitude,
          //       AppConstants.defaultLongitude,
          //     ),
          //     zoom: AppConstants.defaultMapZoom,
          //   ),
          //   markers: controller.markers.value,
          //   onMapCreated: controller.onMapCreated,
          //   myLocationEnabled: true,
          //   myLocationButtonEnabled: false,
          //   zoomControlsEnabled: false,
          //   mapToolbarEnabled: false,
          // )),
          
          // Top gradient overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: padding.top + 120,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.white,
                    AppColors.white.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
          
          // Search Bar
          Positioned(
            top: padding.top + 16,
            left: 20,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowMedium,
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.grey200,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.searchController,
                            decoration: InputDecoration(
                              hintText: '거래처, 창고 검색',
                              hintStyle: TextStyle(
                                color: AppColors.textTertiary,
                              ),
                              prefixIcon: Icon(
                                Icons.search_rounded,
                                color: AppColors.grey500,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 18,
                              ),
                            ),
                            onSubmitted: controller.searchLocation,
                          ),
                        ),
                        Container(
                          height: 40,
                          width: 1,
                          color: AppColors.grey200,
                        ),
                        IconButton(
                          icon: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.primarySurface,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.filter_list_rounded,
                              color: AppColors.primary,
                              size: 20,
                            ),
                          ),
                          onPressed: () => _showFilterBottomSheet(context, controller),
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Bottom controls
          Positioned(
            bottom: padding.bottom + 100,
            right: 20,
            child: Column(
              children: [
                // My Location Button
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: FloatingActionButton(
                    heroTag: 'location',
                    backgroundColor: AppColors.white,
                    onPressed: controller.moveToMyLocation,
                    child: ShaderMask(
                      shaderCallback: (bounds) => AppColors.primaryGradient.createShader(bounds),
                      child: const Icon(
                        Icons.my_location_rounded,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Zoom In
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: FloatingActionButton(
                    heroTag: 'zoom_in',
                    mini: true,
                    backgroundColor: AppColors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.add_rounded,
                      color: AppColors.grey600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Zoom Out
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: FloatingActionButton(
                    heroTag: 'zoom_out',
                    mini: true,
                    backgroundColor: AppColors.white,
                    onPressed: () {},
                    child: Icon(
                      Icons.remove_rounded,
                      color: AppColors.grey600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Legend
          Positioned(
            bottom: padding.bottom + 100,
            left: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.grey200,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '범례',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _buildLegendItem(
                        context,
                        '거래처',
                        Icons.store_rounded,
                        AppColors.primary,
                      ),
                      const SizedBox(height: 10),
                      _buildLegendItem(
                        context,
                        '창고',
                        Icons.warehouse_rounded,
                        AppColors.secondary,
                      ),
                      const SizedBox(height: 10),
                      _buildLegendItem(
                        context,
                        '배송중',
                        Icons.local_shipping_rounded,
                        AppColors.info,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSampleMarker(IconData icon, Color color) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: AppColors.white,
        size: 20,
      ),
    );
  }

  Widget _buildLegendItem(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
  ) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 14,
            color: color,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  void _showFilterBottomSheet(BuildContext context, MapController controller) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowDark,
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '지도 필터',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: controller.resetFilters,
                          icon: const Icon(Icons.refresh_rounded, size: 18),
                          label: const Text('초기화'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '표시할 항목을 선택하세요',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    Obx(() => _buildFilterItem(
                      context,
                      '거래처',
                      Icons.store_rounded,
                      AppColors.primary,
                      controller.showCustomers.value,
                      (value) {
                        controller.showCustomers.value = value ?? true;
                        controller.applyFilters();
                      },
                    )),
                    const SizedBox(height: 16),
                    
                    Obx(() => _buildFilterItem(
                      context,
                      '창고',
                      Icons.warehouse_rounded,
                      AppColors.secondary,
                      controller.showWarehouses.value,
                      (value) {
                        controller.showWarehouses.value = value ?? true;
                        controller.applyFilters();
                      },
                    )),
                    const SizedBox(height: 16),
                    
                    Obx(() => _buildFilterItem(
                      context,
                      '배송 차량',
                      Icons.local_shipping_rounded,
                      AppColors.info,
                      controller.showDeliveries.value,
                      (value) {
                        controller.showDeliveries.value = value ?? true;
                        controller.applyFilters();
                      },
                    )),
                    
                    const SizedBox(height: 32),
                    
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          '적용하기',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 16),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterItem(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    bool value,
    ValueChanged<bool?> onChanged,
  ) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: value ? color.withOpacity(0.1) : AppColors.grey50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: value ? color.withOpacity(0.3) : AppColors.grey200,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: value ? color.withOpacity(0.2) : AppColors.grey200,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: value ? color : AppColors.grey500,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: value ? AppColors.textPrimary : AppColors.textSecondary,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: value ? color : Colors.transparent,
                border: Border.all(
                  color: value ? color : AppColors.grey400,
                  width: 2,
                ),
              ),
              child: value
                  ? const Icon(
                      Icons.check_rounded,
                      size: 16,
                      color: AppColors.white,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}