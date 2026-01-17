import '../constants/app_constants.dart';

/// مساعد التحقق من صحة البيانات
class Validators {
  Validators._();

  /// التحقق من أن الحقل ليس فارغاً
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? "هذا الحقل"} مطلوب';
    }
    return null;
  }

  /// التحقق من اسم المستخدم
  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'اسم المستخدم مطلوب';
    }

    if (value.length < 3) {
      return 'اسم المستخدم يجب أن يكون 3 أحرف على الأقل';
    }

    if (value.length > AppConstants.maxUsernameLength) {
      return 'اسم المستخدم يجب ألا يتجاوز ${AppConstants.maxUsernameLength} حرف';
    }

    // يجب أن يحتوي على حروف وأرقام فقط
    if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
      return 'اسم المستخدم يجب أن يحتوي على حروف وأرقام فقط';
    }

    return null;
  }

  /// التحقق من كلمة المرور
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'كلمة المرور مطلوبة';
    }

    if (value.length < 6) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }

    return null;
  }

  /// التحقق من تطابق كلمة المرور
  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'تأكيد كلمة المرور مطلوب';
    }

    if (value != password) {
      return 'كلمة المرور غير متطابقة';
    }

    return null;
  }

  /// التحقق من الاسم الكامل
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'الاسم الكامل مطلوب';
    }

    if (value.trim().length < 3) {
      return 'الاسم يجب أن يكون 3 أحرف على الأقل';
    }

    return null;
  }

  /// التحقق من الرقم
  static String? number(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '${fieldName ?? "هذا الحقل"} مطلوب';
    }

    if (double.tryParse(value) == null) {
      return 'الرجاء إدخال رقم صحيح';
    }

    return null;
  }

  /// التحقق من الرقم الموجب
  static String? positiveNumber(String? value, {String? fieldName}) {
    final error = number(value, fieldName: fieldName);
    if (error != null) return error;

    final num = double.parse(value!);
    if (num <= 0) {
      return '${fieldName ?? "الرقم"} يجب أن يكون أكبر من صفر';
    }

    return null;
  }

  /// التحقق من الرقم الموجب أو صفر
  static String? nonNegativeNumber(String? value, {String? fieldName}) {
    final error = number(value, fieldName: fieldName);
    if (error != null) return error;

    final num = double.parse(value!);
    if (num < 0) {
      return '${fieldName ?? "الرقم"} يجب ألا يكون سالباً';
    }

    return null;
  }

  /// التحقق من السعر
  static String? price(String? value) {
    return positiveNumber(value, fieldName: 'السعر');
  }

  /// التحقق من الكمية
  static String? quantity(String? value) {
    return positiveNumber(value, fieldName: 'الكمية');
  }

  /// التحقق من الخصم
  static String? discount(String? value, {double? maxDiscount}) {
    if (value == null || value.trim().isEmpty) {
      return null; // الخصم اختياري
    }

    final error = nonNegativeNumber(value, fieldName: 'الخصم');
    if (error != null) return error;

    if (maxDiscount != null) {
      final discountValue = double.parse(value);
      if (discountValue > maxDiscount) {
        return 'الخصم يجب ألا يتجاوز $maxDiscount';
      }
    }

    return null;
  }

  /// التحقق من الحد الأقصى للطول
  static String? maxLength(String? value, int max, {String? fieldName}) {
    if (value == null || value.isEmpty) return null;

    if (value.length > max) {
      return '${fieldName ?? "هذا الحقل"} يجب ألا يتجاوز $max حرف';
    }

    return null;
  }

  /// التحقق من الحد الأدنى للطول
  static String? minLength(String? value, int min, {String? fieldName}) {
    if (value == null || value.isEmpty) return null;

    if (value.length < min) {
      return '${fieldName ?? "هذا الحقل"} يجب أن يكون $min أحرف على الأقل';
    }

    return null;
  }

  /// التحقق من اسم الصنف
  static String? itemName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'اسم الصنف مطلوب';
    }

    if (value.trim().length < 2) {
      return 'اسم الصنف يجب أن يكون حرفين على الأقل';
    }

    if (value.length > AppConstants.maxItemNameLength) {
      return 'اسم الصنف يجب ألا يتجاوز ${AppConstants.maxItemNameLength} حرف';
    }

    return null;
  }

  /// التحقق من الملاحظات
  static String? notes(String? value) {
    if (value == null || value.isEmpty) return null;

    if (value.length > AppConstants.maxNotesLength) {
      return 'الملاحظات يجب ألا تتجاوز ${AppConstants.maxNotesLength} حرف';
    }

    return null;
  }

  /// التحقق من البريد الإلكتروني (للتوسع المستقبلي)
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'البريد الإلكتروني مطلوب';
    }

    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'البريد الإلكتروني غير صحيح';
    }

    return null;
  }

  /// التحقق من رقم الهاتف (للتوسع المستقبلي)
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'رقم الهاتف مطلوب';
    }

    // رقم سعودي (05xxxxxxxx)
    final phoneRegex = RegExp(r'^(05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$');

    if (!phoneRegex.hasMatch(value)) {
      return 'رقم الهاتف غير صحيح';
    }

    return null;
  }

  /// دمج عدة Validators
  static String? combine(
    String? value,
    List<String? Function(String?)> validators,
  ) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  }
}
