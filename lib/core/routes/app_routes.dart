import 'package:get/get.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/auth/bindings/auth_binding.dart';
import '../../features/dashboard/bindings/dashboard_binding.dart';
import '../../shared/widgets/main_layout.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String main = '/main';
  static const String dashboard = '/dashboard';
  static const String menu = '/menu';
  static const String map = '/map';
  static const String chat = '/chat';
  static const String settings = '/settings';
  
  // Sub routes
  static const String customerList = '/customer-list';
  static const String customerDetail = '/customer-detail';
  static const String productList = '/product-list';
  static const String productDetail = '/product-detail';
  static const String orderList = '/order-list';
  static const String orderDetail = '/order-detail';
  static const String inventoryList = '/inventory-list';
  static const String settlementList = '/settlement-list';
  static const String profile = '/profile';
  static const String changePassword = '/change-password';
  static const String notifications = '/notifications';
  
  static final routes = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: main,
      page: () => const MainLayout(),
      binding: DashboardBinding(),
    ),
  ];
}
