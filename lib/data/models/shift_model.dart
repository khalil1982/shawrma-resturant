import '../../domain/entities/shift.dart';
import '../../core/utils/date_utils.dart';

/// Shift model extending Shift entity with database conversion
class ShiftModel extends Shift {
  const ShiftModel({
    required super.id,
    required super.shiftType,
    required super.shiftDate,
    required super.openedByUserId,
    required super.openedAt,
    required super.openingCash,
    super.openingCashAdjustment,
    super.openingCashAdjustmentReason,
    super.openingCashAdjustedByUserId,
    super.closedByUserId,
    super.closedAt,
    super.expectedClosingCash,
    super.actualClosingCash,
    super.cashVariance,
    super.cashVarianceReason,
    super.totalSales,
    super.totalOrders,
    super.cancelledOrders,
    super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create ShiftModel from Shift entity
  factory ShiftModel.fromEntity(Shift shift) {
    return ShiftModel(
      id: shift.id,
      shiftType: shift.shiftType,
      shiftDate: shift.shiftDate,
      openedByUserId: shift.openedByUserId,
      openedAt: shift.openedAt,
      openingCash: shift.openingCash,
      openingCashAdjustment: shift.openingCashAdjustment,
      openingCashAdjustmentReason: shift.openingCashAdjustmentReason,
      openingCashAdjustedByUserId: shift.openingCashAdjustedByUserId,
      closedByUserId: shift.closedByUserId,
      closedAt: shift.closedAt,
      expectedClosingCash: shift.expectedClosingCash,
      actualClosingCash: shift.actualClosingCash,
      cashVariance: shift.cashVariance,
      cashVarianceReason: shift.cashVarianceReason,
      totalSales: shift.totalSales,
      totalOrders: shift.totalOrders,
      cancelledOrders: shift.cancelledOrders,
      status: shift.status,
      createdAt: shift.createdAt,
      updatedAt: shift.updatedAt,
    );
  }

  /// Create ShiftModel from database map
  factory ShiftModel.fromMap(Map<String, dynamic> map) {
    return ShiftModel(
      id: map['id'] as String,
      shiftType: map['shift_type'] as String,
      shiftDate: AppDateUtils.fromDbFormat(map['shift_date'] as String),
      openedByUserId: map['opened_by_user_id'] as String,
      openedAt: AppDateUtils.fromDbFormat(map['opened_at'] as String),
      openingCash: (map['opening_cash'] as num).toDouble(),
      openingCashAdjustment: map['opening_cash_adjustment'] != null
          ? (map['opening_cash_adjustment'] as num).toDouble()
          : null,
      openingCashAdjustmentReason:
          map['opening_cash_adjustment_reason'] as String?,
      openingCashAdjustedByUserId:
          map['opening_cash_adjusted_by_user_id'] as String?,
      closedByUserId: map['closed_by_user_id'] as String?,
      closedAt: map['closed_at'] != null
          ? AppDateUtils.fromDbFormat(map['closed_at'] as String)
          : null,
      expectedClosingCash: (map['expected_closing_cash'] as num).toDouble(),
      actualClosingCash: (map['actual_closing_cash'] as num).toDouble(),
      cashVariance: (map['cash_variance'] as num).toDouble(),
      cashVarianceReason: map['cash_variance_reason'] as String?,
      totalSales: (map['total_sales'] as num).toDouble(),
      totalOrders: map['total_orders'] as int,
      cancelledOrders: map['cancelled_orders'] as int,
      status: map['status'] as String,
      createdAt: AppDateUtils.fromDbFormat(map['created_at'] as String),
      updatedAt: AppDateUtils.fromDbFormat(map['updated_at'] as String),
    );
  }

  /// Convert ShiftModel to database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'shift_type': shiftType,
      'shift_date': AppDateUtils.toDbFormat(shiftDate),
      'opened_by_user_id': openedByUserId,
      'opened_at': AppDateUtils.toDbFormat(openedAt),
      'opening_cash': openingCash,
      'opening_cash_adjustment': openingCashAdjustment,
      'opening_cash_adjustment_reason': openingCashAdjustmentReason,
      'opening_cash_adjusted_by_user_id': openingCashAdjustedByUserId,
      'closed_by_user_id': closedByUserId,
      'closed_at': closedAt != null ? AppDateUtils.toDbFormat(closedAt!) : null,
      'expected_closing_cash': expectedClosingCash,
      'actual_closing_cash': actualClosingCash,
      'cash_variance': cashVariance,
      'cash_variance_reason': cashVarianceReason,
      'total_sales': totalSales,
      'total_orders': totalOrders,
      'cancelled_orders': cancelledOrders,
      'status': status,
      'created_at': AppDateUtils.toDbFormat(createdAt),
      'updated_at': AppDateUtils.toDbFormat(updatedAt),
    };
  }
}
