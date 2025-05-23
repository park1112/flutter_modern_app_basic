import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_colors.dart';

class MapController extends GetxController {
  // GoogleMapController? mapController;
  final TextEditingController searchController = TextEditingController();
  
  // Map markers
  // final markers = <Marker>{}.obs;
  
  // Filter states
  final showCustomers = true.obs;
  final showWarehouses = true.obs;
  final showDeliveries = true.obs;
  
  // Current location
  Position? currentPosition;
  
  @override
  void onInit() {
    super.onInit();
    _loadMarkers();
    _getCurrentLocation();
  }
  
  @override
  void onClose() {
    searchController.dispose();
    // mapController?.dispose();
    super.onClose();
  }
  
  // void onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }
  
  Future<void> _getCurrentLocation() async {
    try {
      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      
      if (permission == LocationPermission.deniedForever) {
        Get.snackbar(
          '위치 권한',
          '설정에서 위치 권한을 허용해주세요.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }
      
      // Get current position
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      // TODO: Google Maps 설정 후 주석 해제
      // Move camera to current location
      // if (mapController != null && currentPosition != null) {
      //   mapController!.animateCamera(
      //     CameraUpdate.newLatLng(
      //       LatLng(currentPosition!.latitude, currentPosition!.longitude),
      //     ),
      //   );
      // }
    } catch (e) {
      debugPrint('Error getting location: $e');
    }
  }
  
  void _loadMarkers() {
    // TODO: Google Maps 설정 후 주석 해제
    // TODO: Load markers from Supabase
    // For now, using mock data
    
    // final Set<Marker> allMarkers = {};
    
    // Customer markers
    // if (showCustomers.value) {
    //   allMarkers.addAll([
    //     Marker(
    //       markerId: const MarkerId('customer1'),
    //       position: const LatLng(37.5665, 126.9780),
    //       infoWindow: const InfoWindow(
    //         title: '농협하나로마트 서울점',
    //         snippet: '거래처',
    //       ),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(
    //         BitmapDescriptor.hueGreen,
    //       ),
    //     ),
    //     Marker(
    //       markerId: const MarkerId('customer2'),
    //       position: const LatLng(37.5700, 126.9850),
    //       infoWindow: const InfoWindow(
    //         title: '이마트 강남점',
    //         snippet: '거래처',
    //       ),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(
    //         BitmapDescriptor.hueGreen,
    //       ),
    //     ),
    //   ]);
    // }
    
    // Warehouse markers
    // if (showWarehouses.value) {
    //   allMarkers.addAll([
    //     Marker(
    //       markerId: const MarkerId('warehouse1'),
    //       position: const LatLng(37.5600, 126.9750),
    //       infoWindow: const InfoWindow(
    //         title: '중앙 물류 창고',
    //         snippet: '창고',
    //       ),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(
    //         BitmapDescriptor.hueOrange,
    //       ),
    //     ),
    //   ]);
    // }
    
    // Delivery markers
    // if (showDeliveries.value) {
    //   allMarkers.addAll([
    //     Marker(
    //       markerId: const MarkerId('delivery1'),
    //       position: const LatLng(37.5680, 126.9800),
    //       infoWindow: const InfoWindow(
    //         title: '배송차량 #001',
    //         snippet: '배송중',
    //       ),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(
    //         BitmapDescriptor.hueBlue,
    //       ),
    //     ),
    //   ]);
    // }
    
    // markers.value = allMarkers;
  }
  
  void searchLocation(String query) {
    // TODO: Implement location search
    Get.snackbar(
      '준비 중',
      '검색 기능은 준비 중입니다.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  
  void clearSearch() {
    searchController.clear();
  }
  
  void moveToMyLocation() {
    if (currentPosition != null) {
      // TODO: Google Maps 설정 후 주석 해제
      // if (mapController != null) {
      //   mapController!.animateCamera(
      //     CameraUpdate.newLatLng(
      //       LatLng(currentPosition!.latitude, currentPosition!.longitude),
      //     ),
      //   );
      // }
      Get.snackbar(
        '현재 위치',
        '위도: ${currentPosition!.latitude}, 경도: ${currentPosition!.longitude}',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      _getCurrentLocation();
    }
  }
  
  void applyFilters() {
    _loadMarkers();
  }
  
  void resetFilters() {
    showCustomers.value = true;
    showWarehouses.value = true;
    showDeliveries.value = true;
    applyFilters();
  }
}
