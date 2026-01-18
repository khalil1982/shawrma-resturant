import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../../core/utils/date_utils.dart';
import '../../entities/shift.dart';
import '../../repositories/shift_repository.dart';

/// Parameters for opening a shift
class OpenShiftParams {
  final String shiftType;
  final DateTime shiftDate;
  final String openedByUserId;
  final double openingCash;
  final double? openingCashAdjustment;
  final String? openingCashAdjustmentReason;
  final String? openingCashAdjustedByUserId;

  OpenShiftParams({
    required this.shiftType,
    required this.shiftDate,
    required this.openedByUserId,
    required this.openingCash,
    this.openingCashAdjustment,
    this.openingCashAdjustmentReason,
    this.openingCashAdjustedByUserId,
  });
}

/// Use case for opening a shift
class OpenShift {
  final ShiftRepository repository;

  OpenShift(this.repository);

  Future<Either<Failure, Shift>> call(OpenShiftParams params) async {
    // 1. Check if there's an active shift
    final activeShiftResult = await repository.getActiveShift();
    if (activeShiftResult.isLeft()) {
      return Left(
        activeShiftResult.fold((failure) => failure, (_) => throw Exception()),
      );
    }

    final activeShift = activeShiftResult.getOrElse(() => null);
    if (activeShift != null) {
      return const Left(
        BusinessLogicFailure('يوجد وردية نشطة بالفعل. يجب إغلاقها أولاً'),
      );
    }

    // 2. Validate shift type
    if (params.shiftType != 'morning' && params.shiftType != 'evening') {
      return const Left(ValidationFailure('نوع الوردية غير صحيح'));
    }

    // 3. Validate opening cash adjustment
    if (params.openingCashAdjustment != null &&
        params.openingCashAdjustmentReason == null) {
      return const Left(
        ValidationFailure('سبب تعديل النقد الافتتاحي مطلوب'),
      );
    }

    if (params.openingCashAdjustment != null &&
        params.openingCashAdjustedByUserId == null) {
      return const Left(
        ValidationFailure('معرف المستخدم الذي قام بالتعديل مطلوب'),
      );
    }

    // 4. Get opening cash from last shift (if no adjustment is provided)
    double finalOpeningCash = params.openingCash;
    if (params.openingCashAdjustment == null) {
      final lastShiftResult = await repository.getLastClosedShift();
      if (lastShiftResult.isRight()) {
        final lastShift = lastShiftResult.getOrElse(() => null);
        if (lastShift != null) {
          finalOpeningCash = lastShift.actualClosingCash;
        }
      }
    }

    // 5. Open the shift
    return await repository.openShift(
      shiftType: params.shiftType,
      shiftDate: params.shiftDate,
      openedByUserId: params.openedByUserId,
      openingCash: finalOpeningCash,
      openingCashAdjustment: params.openingCashAdjustment,
      openingCashAdjustmentReason: params.openingCashAdjustmentReason,
      openingCashAdjustedByUserId: params.openingCashAdjustedByUserId,
    );
  }
}
