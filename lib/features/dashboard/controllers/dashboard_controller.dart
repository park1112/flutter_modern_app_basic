import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class DashboardController extends GetxController {
  // User info
  final userName = ''.obs;
  final unreadNotifications = 0.obs;
  
  // Summary data
  final todaySales = '₩0'.obs;
  final newOrders = 0.obs;
  final inventoryStatus = 85.obs;
  final receivables = '₩0'.obs;
  
  // Trends
  final salesTrend = 0.0.obs;
  final ordersTrend = 0.0.obs;
  
  // Chart data
  final weeklySalesData = <FlSpot>[].obs;
  final maxSalesValue = 100.0.obs;
  
  // Top products
  final topProducts = <Map<String, dynamic>>[].obs;
  
  // Number formatter
  final currencyFormat = NumberFormat.currency(locale: 'ko_KR', symbol: '₩');
  
  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }
  
  Future<void> loadDashboardData() async {
    // TODO: Load actual data from Supabase
    // For now, using mock data
    
    // User info
    userName.value = '홍길동';
    unreadNotifications.value = 3;
    
    // Summary data
    todaySales.value = currencyFormat.format(2850000);
    newOrders.value = 12;
    inventoryStatus.value = 85;
    receivables.value = currencyFormat.format(5200000);
    
    // Trends
    salesTrend.value = 12.5; // +12.5%
    ordersTrend.value = -5.2; // -5.2%
    
    // Weekly sales chart data
    weeklySalesData.value = [
      const FlSpot(0, 45),
      const FlSpot(1, 52),
      const FlSpot(2, 48),
      const FlSpot(3, 65),
      const FlSpot(4, 72),
      const FlSpot(5, 58),
      const FlSpot(6, 45),
    ];
    
    maxSalesValue.value = 100;
    
    // Top products
    topProducts.value = [
      {
        'name': '프리미엄 토마토',
        'quantity': 152,
        'sales': currencyFormat.format(456000),
      },
      {
        'name': '유기농 상추',
        'quantity': 98,
        'sales': currencyFormat.format(294000),
      },
      {
        'name': '청양고추',
        'quantity': 87,
        'sales': currencyFormat.format(261000),
      },
      {
        'name': '대파',
        'quantity': 76,
        'sales': currencyFormat.format(228000),
      },
      {
        'name': '애호박',
        'quantity': 65,
        'sales': currencyFormat.format(195000),
      },
    ];
  }
  
  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    await loadDashboardData();
  }
}
