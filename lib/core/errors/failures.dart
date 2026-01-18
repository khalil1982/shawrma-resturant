import 'package:equatable/equatable.dart';

/// Base failure class
abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Database-related failures
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

/// Authentication failures
class AuthenticationFailure extends Failure {
  const AuthenticationFailure(super.message);
}

/// Validation failures
class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}

/// Business logic failures
class BusinessLogicFailure extends Failure {
  const BusinessLogicFailure(super.message);
}

/// Not found failures
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message);
}

/// Cache failures
class CacheFailure extends Failure {
  const CacheFailure(super.message);
}
