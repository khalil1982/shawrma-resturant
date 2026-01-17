/// أدوار المستخدمين
enum UserRole {
  admin('admin', 'مدير'),
  cashier('cashier', 'كاشير'),
  kitchen('kitchen', 'مطبخ');

  final String value;
  final String arabicName;

  const UserRole(this.value, this.arabicName);

  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.cashier,
    );
  }

  @override
  String toString() => value;
}

/// حالات الطلب
enum OrderStatus {
  pending('pending', 'قيد الانتظار'),
  preparing('preparing', 'قيد التحضير'),
  ready('ready', 'جاهز'),
  completed('completed', 'مكتمل'),
  cancelled('cancelled', 'ملغي');

  final String value;
  final String arabicName;

  const OrderStatus(this.value, this.arabicName);

  static OrderStatus fromString(String value) {
    return OrderStatus.values.firstWhere(
      (status) => status.value == value,
      orElse: () => OrderStatus.pending,
    );
  }

  @override
  String toString() => value;
}

/// طرق الدفع
enum PaymentMethod {
  cash('cash', 'نقداً'),
  card('card', 'بطاقة');

  final String value;
  final String arabicName;

  const PaymentMethod(this.value, this.arabicName);

  static PaymentMethod fromString(String value) {
    return PaymentMethod.values.firstWhere(
      (method) => method.value == value,
      orElse: () => PaymentMethod.cash,
    );
  }

  @override
  String toString() => value;
}

/// أنواع الاستهلاك
enum ConsumptionType {
  order('order', 'طلب'),
  waste('waste', 'هدر'),
  other('other', 'أخرى');

  final String value;
  final String arabicName;

  const ConsumptionType(this.value, this.arabicName);

  static ConsumptionType fromString(String value) {
    return ConsumptionType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => ConsumptionType.other,
    );
  }

  @override
  String toString() => value;
}

/// وحدات القياس للمواد الخام
enum MeasurementUnit {
  kg('kg', 'كيلو'),
  liter('liter', 'لتر'),
  piece('piece', 'قطعة'),
  carton('carton', 'كرتون'),
  gram('gram', 'جرام'),
  ml('ml', 'مل');

  final String value;
  final String arabicName;

  const MeasurementUnit(this.value, this.arabicName);

  static MeasurementUnit fromString(String value) {
    return MeasurementUnit.values.firstWhere(
      (unit) => unit.value == value,
      orElse: () => MeasurementUnit.kg,
    );
  }

  @override
  String toString() => value;
}

/// أنواع الصلاحيات
enum PermissionType {
  viewReports('view_reports', 'عرض التقارير'),
  editPrices('edit_prices', 'تعديل الأسعار'),
  cancelOrders('cancel_orders', 'إلغاء الطلبات'),
  manageUsers('manage_users', 'إدارة المستخدمين'),
  manageItems('manage_items', 'إدارة الأصناف'),
  manageInventory('manage_inventory', 'إدارة المخزون'),
  exportReports('export_reports', 'تصدير التقارير'),
  viewCosts('view_costs', 'عرض التكاليف');

  final String value;
  final String arabicName;

  const PermissionType(this.value, this.arabicName);

  static PermissionType fromString(String value) {
    return PermissionType.values.firstWhere(
      (permission) => permission.value == value,
      orElse: () => throw Exception('Unknown permission: $value'),
    );
  }

  @override
  String toString() => value;
}

/// حالة المخزون
enum StockStatus {
  ok('ok', 'جيد'),
  warning('warning', 'تحذير'),
  low('low', 'منخفض'),
  outOfStock('out_of_stock', 'نفذ');

  final String value;
  final String arabicName;

  const StockStatus(this.value, this.arabicName);

  @override
  String toString() => value;
}

/// نوع التقرير
enum ReportType {
  dailySales('daily_sales', 'مبيعات يومية'),
  monthlySales('monthly_sales', 'مبيعات شهرية'),
  profitLoss('profit_loss', 'الأرباح والخسائر'),
  inventory('inventory', 'المخزون'),
  topItems('top_items', 'الأصناف الأكثر مبيعاً'),
  cashierPerformance('cashier_performance', 'أداء الكاشير');

  final String value;
  final String arabicName;

  const ReportType(this.value, this.arabicName);

  @override
  String toString() => value;
}

/// نوع التصدير
enum ExportFormat {
  pdf('pdf', 'PDF'),
  excel('excel', 'Excel'),
  csv('csv', 'CSV');

  final String value;
  final String arabicName;

  const ExportFormat(this.value, this.arabicName);

  @override
  String toString() => value;
}
