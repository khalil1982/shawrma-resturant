/// Application-wide constants
class AppConstants {
  // App Info
  static const String appName = 'شاورما بازل';
  static const String appNameEnglish = 'Shawarma Basel';
  static const String appVersion = '1.0.0';

  // Default Users
  static const String defaultOwnerUsername = 'admin';
  static const String defaultOwnerPassword = 'admin123';
  static const String defaultCashierUsername = 'cashier';
  static const String defaultCashierPassword = 'cashier123';

  // Business Rules
  static const int defaultCustomerCount = 1;
  static const double maxCashierDiscountPercent = 5.0;

  // Date Formats
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'dd/MM/yyyy';
  static const String displayTimeFormat = 'HH:mm';

  // Validation
  static const int minPasswordLength = 6;
  static const int maxNotesLength = 500;

  // UI
  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 8.0;
  static const double buttonHeight = 48.0;
  static const double cardElevation = 2.0;
}
