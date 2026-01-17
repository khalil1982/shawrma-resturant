import 'package:intl/intl.dart';
import '../constants/app_constants.dart';

/// مساعد تنسيق العملة
class CurrencyFormatter {
  CurrencyFormatter._();

  static final _formatter = NumberFormat('#,##0.00', 'ar_SA');

  /// تنسيق المبلغ
  static String format(double amount) {
    return '${_formatter.format(amount)} ${AppConstants.defaultCurrency}';
  }

  /// تنسيق المبلغ بدون رمز العملة
  static String formatNumber(double amount) {
    return _formatter.format(amount);
  }

  /// تحويل النص إلى رقم
  static double? parse(String? text) {
    if (text == null || text.isEmpty) return null;

    // إزالة رمز العملة والفواصل
    final cleanText = text
        .replaceAll(AppConstants.defaultCurrency, '')
        .replaceAll(',', '')
        .trim();

    return double.tryParse(cleanText);
  }

  /// تنسيق السعر مع التقريب
  static String formatPrice(double price, {int decimals = 2}) {
    final formatter = NumberFormat('#,##0.${'0' * decimals}', 'ar_SA');
    return '${formatter.format(price)} ${AppConstants.defaultCurrency}';
  }

  /// تنسيق الخصم
  static String formatDiscount(double discount) {
    if (discount == 0) return 'بدون خصم';
    return format(discount);
  }

  /// حساب النسبة المئوية
  static String formatPercentage(double percentage) {
    return '${percentage.toStringAsFixed(1)}%';
  }

  /// حساب الربح
  static String formatProfit(double cost, double sell) {
    final profit = sell - cost;
    final percentage = cost > 0 ? (profit / cost) * 100 : 0;
    return '${format(profit)} (${formatPercentage(percentage)})';
  }
}
