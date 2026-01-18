import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/user.dart';
import '../../repositories/user_repository.dart';

/// Use case for authenticating a user
class AuthenticateUser {
  final UserRepository repository;

  AuthenticateUser(this.repository);

  Future<Either<Failure, User>> call(String username, String password) async {
    // Validate input
    if (username.trim().isEmpty) {
      return const Left(ValidationFailure('اسم المستخدم مطلوب'));
    }
    if (password.isEmpty) {
      return const Left(ValidationFailure('كلمة المرور مطلوبة'));
    }

    // Authenticate
    return await repository.authenticate(username.trim(), password);
  }
}
