/// Base exception class
class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

/// Database-related exceptions
class DatabaseException extends AppException {
  const DatabaseException(super.message);
}

/// Authentication exceptions
class AuthenticationException extends AppException {
  const AuthenticationException(super.message);
}

/// Validation exceptions
class ValidationException extends AppException {
  const ValidationException(super.message);
}

/// Business logic exceptions
class BusinessLogicException extends AppException {
  const BusinessLogicException(super.message);
}

/// Not found exceptions
class NotFoundException extends AppException {
  const NotFoundException(super.message);
}

/// Cache exceptions
class CacheException extends AppException {
  const CacheException(super.message);
}
