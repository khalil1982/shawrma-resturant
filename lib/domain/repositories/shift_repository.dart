import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/shift.dart';

/// Shift repository interface
abstract class ShiftRepository {
  /// Get active shift
  Future<Either<Failure, Shift?>> getActiveShift();

  /// Open a new shift
  Future<Either<Failure, Shift>> openShift({
    required String shiftType,
    required DateTime shiftDate,
    required String openedByUserId,
    required double openingCash,
    double? openingCashAdjustment,
    String? openingCashAdjustmentReason,
    String? openingCashAdjustedByUserId,
  });

  /// Close shift
  Future<Either<Failure, Shift>> closeShift({
    required String shiftId,
    required String closedByUserId,
    required double actualClosingCash,
    String? cashVarianceReason,
  });

  /// Get shift by ID
  Future<Either<Failure, Shift>> getShiftById(String id);

  /// Get last closed shift
  Future<Either<Failure, Shift?>> getLastClosedShift();

  /// Update shift statistics (total sales, orders, etc.)
  Future<Either<Failure, Shift>> updateShiftStatistics({
    required String shiftId,
    double? totalSales,
    int? totalOrders,
    int? cancelledOrders,
  });
}
