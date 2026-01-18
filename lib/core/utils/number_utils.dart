import 'package:intl/intl.dart';

/// Number utility functions - especially for financial calculations
class AppNumberUtils {
  /// Format double to currency string (e.g., "120.00 ₪")
  static String toCurrency(double amount, {bool showSymbol = true}) {
    final formatted = amount.toStringAsFixed(2);
    return showSymbol ? '$formatted ₪' : formatted;
  }

  /// Parse string to double, return 0 if invalid
  static double parseDouble(String value) {
    return double.tryParse(value) ?? 0.0;
  }

  /// Round to 2 decimal places (for display only, not for calculations)
  static double roundTo2Decimals(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  /// Format number with thousand separators
  static String formatWithSeparators(double number) {
    final formatter = NumberFormat('#,##0.00');
    return formatter.format(number);
  }

  /// Check if two doubles are equal (accounting for floating point precision)
  static bool areEqual(double a, double b, {double epsilon = 0.001}) {
    return (a - b).abs() < epsilon;
  }

  /// Calculate percentage
  static double calculatePercentage(double value, double percentage) {
    return (value * percentage) / 100;
  }

  /// Check if value is positive
  static bool isPositive(double value) {
    return value > 0;
  }

  /// Check if value is zero or close to zero
  static bool isZero(double value, {double epsilon = 0.001}) {
    return value.abs() < epsilon;
  }
}
