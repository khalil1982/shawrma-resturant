import 'package:flutter/material.dart';

/// ألوان التطبيق
class AppColors {
  AppColors._();

  // الألوان الرئيسية
  static const Color primary = Color(0xFF4CAF50); // أخضر
  static const Color primaryDark = Color(0xFF388E3C);
  static const Color primaryLight = Color(0xFF81C784);

  static const Color secondary = Color(0xFFFF9800); // برتقالي
  static const Color secondaryDark = Color(0xFFF57C00);
  static const Color secondaryLight = Color(0xFFFFB74D);

  static const Color accent = Color(0xFFFFEB3B); // أصفر
  static const Color accentDark = Color(0xFFFBC02D);

  // ألوان الخلفية
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDark = Color(0xFF263238);

  // ألوان النصوص
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFFFFFFF);
  static const Color textDisabled = Color(0xFFBDBDBD);

  // ألوان الحالة
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // ألوان حالة الطلب
  static const Color orderPending = Color(0xFF9E9E9E); // رمادي
  static const Color orderPreparing = Color(0xFFFF9800); // برتقالي
  static const Color orderReady = Color(0xFF2196F3); // أزرق
  static const Color orderCompleted = Color(0xFF4CAF50); // أخضر
  static const Color orderCancelled = Color(0xFFF44336); // أحمر

  // ألوان حالة المخزون
  static const Color stockOk = Color(0xFF4CAF50);
  static const Color stockWarning = Color(0xFFFF9800);
  static const Color stockLow = Color(0xFFF44336);
  static const Color stockOut = Color(0xFF9E9E9E);

  // ألوان الحدود والخطوط
  static const Color divider = Color(0xFFE0E0E0);
  static const Color border = Color(0xFFBDBDBD);
  static const Color borderLight = Color(0xFFE0E0E0);

  // ألوان الظلال
  static const Color shadow = Color(0x1F000000);
  static const Color shadowLight = Color(0x0A000000);

  // ألوان أخرى
  static const Color card = Color(0xFFFFFFFF);
  static const Color disabled = Color(0xFFE0E0E0);
  static const Color overlay = Color(0x66000000);
}
