class AppConstants {
  // Supabase Configuration
  // TODO: 실제 Supabase 프로젝트 생성 후 값 변경 필요
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // App Info
  static const String appName = 'AgroFlow';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String rememberMeKey = 'remember_me';
  static const String isDarkModeKey = 'is_dark_mode';
  static const String languageKey = 'language_code';
  static const String themeKey = 'theme';

  // API Timeouts
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Pagination
  static const int defaultPageSize = 20;

  // Map
  static const double defaultMapZoom = 15.0;
  static const double defaultLatitude = 37.5665; // Seoul
  static const double defaultLongitude = 126.9780; // Seoul

  // File Size Limits
  static const int maxImageSize = 10 * 1024 * 1024; // 10MB
  static const int maxFileSize = 50 * 1024 * 1024; // 50MB

  // Animation Durations
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);
  static const Duration splashDuration = Duration(seconds: 2);

  // Form Validations
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 20;
  static const int phoneNumberLength = 11;

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm';
  static const String timeFormat = 'HH:mm';
}
