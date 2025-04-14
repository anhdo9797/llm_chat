/// App constants
class AppConstants {
  // Prevent instantiation
  AppConstants._();

  static const String appName = 'BuddBot';

  /// API Endpoints
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = '/v1';

  /// API Timeout
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  /// Storage Keys
  static const String keyAccessToken = 'access_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyUserName = 'user_name';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';

  /// Date Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';

  /// Pagination
  static const int defaultPageSize = 20;
  static const int defaultPage = 1;

  /// File Size Limits (in bytes)
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB

  /// Supported File Types
  static const List<String> supportedImageTypes = [
    'image/jpeg',
    'image/png',
    'image/gif',
  ];

  /// Validation Rules
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const int maxUsernameLength = 50;
  static const int maxNameLength = 100;

  /// Assets path
  static const String assetsImages = 'assets/images';
  static const String assetsIcons = 'assets/icons';

  /// App logo
  static const String appLogo = '$assetsImages/logo.png';
}
