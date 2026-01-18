import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/shift.dart';
import '../../repositories/shift_repository.dart';

/// Parameters for closing a shift
class CloseShiftParams {
  final String shiftId;
  final String closedByUserId;
  final double actualClosingCash;
  final String? cashVarianceReason;

  CloseShiftParams({
    required this.shiftId,
    required this.closedByUserId,
    required this.actualClosingCash,
    this.cashVarianceReason,
  });
}

/// Use case for closing a shift
class CloseShift {
  final ShiftRepository repository;

  CloseShift(this.repository);

  Future<Either<Failure, Shift>> call(CloseShiftParams params) async {
    // 1. Get the shift
    final shiftResult = await repository.getShiftById(params.shiftId);
    if (shiftResult.isLeft()) {
      return Left(
        shiftResult.fold((failure) => failure, (_) => throw Exception()),
      );
    }

    final shift = shiftResult.getOrElse(() => throw Exception());

    // 2. Validate shift is active
    if (!shift.isActive) {
      return const Left(
        BusinessLogicFailure('الوردية مغلقة بالفعل'),
      );
    }

    // 3. Validate actual closing cash
    if (params.actualClosingCash < 0) {
      return const Left(ValidationFailure('النقد الفعلي لا يمكن أن يكون سالباً'));
    }

    // 4. Calculate expected closing cash and variance
    final expectedClosingCash = Shift.calculateExpectedClosingCash(
      shift.finalOpeningCash,
      shift.totalSales,
    );
    final cashVariance = Shift.calculateCashVariance(
      params.actualClosingCash,
      expectedClosingCash,
    );

    // 5. Validate variance reason
    if (cashVariance.abs() > 0.001 && params.cashVarianceReason == null) {
      return const Left(
        ValidationFailure('سبب فروقات النقد مطلوب'),
      );
    }

    // 6. Close the shift
    return await repository.closeShift(
      shiftId: params.shiftId,
      closedByUserId: params.closedByUserId,
      actualClosingCash: params.actualClosingCash,
      cashVarianceReason: params.cashVarianceReason,
    );
  }
}
