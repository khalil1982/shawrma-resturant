/// ثوابت التطبيق الرئيسية
class AppConstants {
  AppConstants._();

  // معلومات التطبيق
  static const String appName = 'نظام إدارة مطعم الشاورما';
  static const String appNameEn = 'Shawarma Restaurant Management';
  static const String appVersion = '1.0.0';
  static const String companyName = 'مطاعم الشاورما';

  // قاعدة البيانات
  static const String databaseName = 'shawarma_restaurant.db';
  static const int databaseVersion = 1;

  // أسماء الجداول
  static const String tableUsers = 'users';
  static const String tableCategories = 'categories';
  static const String tableItems = 'items';
  static const String tableOrders = 'orders';
  static const String tableOrderItems = 'order_items';
  static const String tableRawMaterials = 'raw_materials';
  static const String tablePurchases = 'purchases';
  static const String tableConsumption = 'consumption';
  static const String tableItemMaterials = 'item_materials';
  static const String tablePermissions = 'permissions';

  // حدود البيانات
  static const int maxItemNameLength = 100;
  static const int maxUsernameLength = 50;
  static const int maxNotesLength = 500;
  static const int maxOrderItems = 100;

  // الإعدادات الافتراضية
  static const double defaultTaxRate = 0.0; // يمكن تعديلها لاحقاً
  static const String defaultCurrency = 'ر.س';
  static const String dateFormat = 'yyyy-MM-dd';
  static const String timeFormat = 'HH:mm:ss';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // التقارير
  static const String reportDateFormat = 'dd/MM/yyyy';
  static const int reportMaxRows = 10000;
}
