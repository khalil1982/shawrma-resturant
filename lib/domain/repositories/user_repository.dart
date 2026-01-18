import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/user.dart';

/// User repository interface
abstract class UserRepository {
  /// Authenticate user with username and password
  Future<Either<Failure, User>> authenticate(
    String username,
    String password,
  );

  /// Get user by ID
  Future<Either<Failure, User>> getUserById(String id);

  /// Get user by username
  Future<Either<Failure, User>> getUserByUsername(String username);
}
