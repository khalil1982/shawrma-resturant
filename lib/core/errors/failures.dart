/// الأخطاء الأساسية في التطبيق
abstract class Failure {
  final String message;
  final String? code;

  const Failure(this.message, {this.code});

  @override
  String toString() => message;
}

/// خطأ في قاعدة البيانات
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, {super.code});
}

/// خطأ في المصادقة
class AuthFailure extends Failure {
  const AuthFailure(super.message, {super.code});
}

/// خطأ في الصلاحيات
class PermissionFailure extends Failure {
  const PermissionFailure(super.message, {super.code});
}

/// خطأ في التحقق من البيانات
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.code});
}

/// خطأ في العمليات التجارية
class BusinessLogicFailure extends Failure {
  const BusinessLogicFailure(super.message, {super.code});
}

/// خطأ غير متوقع
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {super.code});
}

/// البيانات غير موجودة
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.code});
}

/// البيانات موجودة مسبقاً
class DuplicateFailure extends Failure {
  const DuplicateFailure(super.message, {super.code});
}

/// خطأ في التصدير
class ExportFailure extends Failure {
  const ExportFailure(super.message, {super.code});
}

/// خطأ في الاستيراد
class ImportFailure extends Failure {
  const ImportFailure(super.message, {super.code});
}
