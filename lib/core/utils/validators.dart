import '../constants/app_constants.dart';

/// Validation utility functions
class Validators {
  /// Validate username
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'اسم المستخدم مطلوب';
    }
    if (value.trim().length < 3) {
      return 'اسم المستخدم يجب أن يكون 3 أحرف على الأقل';
    }
    return null;
  }

  /// Validate password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }
    if (value.length < AppConstants.minPasswordLength) {
      return 'كلمة المرور يجب أن تكون ${AppConstants.minPasswordLength} أحرف على الأقل';
    }
    return null;
  }

  /// Validate required field
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName مطلوب';
    }
    return null;
  }

  /// Validate amount (must be positive)
  static String? validateAmount(String? value, {bool allowZero = false}) {
    if (value == null || value.trim().isEmpty) {
      return 'المبلغ مطلوب';
    }
    final amount = double.tryParse(value);
    if (amount == null) {
      return 'المبلغ غير صحيح';
    }
    if (!allowZero && amount <= 0) {
      return 'المبلغ يجب أن يكون أكبر من صفر';
    }
    if (allowZero && amount < 0) {
      return 'المبلغ لا يمكن أن يكون سالباً';
    }
    return null;
  }

  /// Validate quantity (must be positive integer)
  static String? validateQuantity(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الكمية مطلوبة';
    }
    final quantity = int.tryParse(value);
    if (quantity == null) {
      return 'الكمية غير صحيحة';
    }
    if (quantity <= 0) {
      return 'الكمية يجب أن تكون أكبر من صفر';
    }
    return null;
  }

  /// Validate notes length
  static String? validateNotes(String? value) {
    if (value != null && value.length > AppConstants.maxNotesLength) {
      return 'الملاحظات يجب أن لا تتجاوز ${AppConstants.maxNotesLength} حرف';
    }
    return null;
  }
}
