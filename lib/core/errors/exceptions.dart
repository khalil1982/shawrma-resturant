/// الاستثناءات في طبقة البيانات
class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, {this.code});

  @override
  String toString() => message;
}

/// استثناء قاعدة البيانات
class DatabaseException extends AppException {
  DatabaseException(super.message, {super.code});
}

/// استثناء المصادقة
class AuthException extends AppException {
  AuthException(super.message, {super.code});
}

/// استثناء الصلاحيات
class PermissionException extends AppException {
  PermissionException(super.message, {super.code});
}

/// استثناء التحقق من البيانات
class ValidationException extends AppException {
  ValidationException(super.message, {super.code});
}

/// البيانات غير موجودة
class NotFoundException extends AppException {
  NotFoundException(super.message, {super.code});
}

/// البيانات موجودة مسبقاً
class DuplicateException extends AppException {
  DuplicateException(super.message, {super.code});
}

/// عملية ملغاة
class CancelledException extends AppException {
  CancelledException(super.message, {super.code});
}

/// خطأ في التصدير
class ExportException extends AppException {
  ExportException(super.message, {super.code});
}

/// خطأ في الاستيراد
class ImportException extends AppException {
  ImportException(super.message, {super.code});
}
