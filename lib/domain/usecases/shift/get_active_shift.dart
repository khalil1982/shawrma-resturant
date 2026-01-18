import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/shift.dart';
import '../../repositories/shift_repository.dart';

/// Use case for getting the active shift
class GetActiveShift {
  final ShiftRepository repository;

  GetActiveShift(this.repository);

  Future<Either<Failure, Shift?>> call() async {
    return await repository.getActiveShift();
  }
}
