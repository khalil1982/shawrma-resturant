import 'dart:convert';
import 'package:crypto/crypto.dart';

/// مساعد التشفير
class EncryptionHelper {
  EncryptionHelper._();

  /// تشفير كلمة المرور باستخدام SHA-256
  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hash = sha256.convert(bytes);
    return hash.toString();
  }

  /// التحقق من كلمة المرور
  static bool verifyPassword(String password, String hashedPassword) {
    final hash = hashPassword(password);
    return hash == hashedPassword;
  }

  /// توليد معرف فريد
  static String generateUniqueId() {
    final now = DateTime.now().millisecondsSinceEpoch;
    final random = DateTime.now().microsecond;
    return '$now$random';
  }

  /// تشفير نص عام باستخدام Base64 (للبيانات غير الحساسة)
  static String encodeBase64(String text) {
    final bytes = utf8.encode(text);
    return base64.encode(bytes);
  }

  /// فك تشفير Base64
  static String decodeBase64(String encoded) {
    final bytes = base64.decode(encoded);
    return utf8.decode(bytes);
  }
}
