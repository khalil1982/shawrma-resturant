import 'package:equatable/equatable.dart';

/// Shift entity
class Shift extends Equatable {
  final String id;
  final String shiftType;
  final DateTime shiftDate;
  final String openedByUserId;
  final DateTime openedAt;
  final double openingCash;
  final double? openingCashAdjustment;
  final String? openingCashAdjustmentReason;
  final String? openingCashAdjustedByUserId;
  final String? closedByUserId;
  final DateTime? closedAt;
  final double expectedClosingCash;
  final double actualClosingCash;
  final double cashVariance;
  final String? cashVarianceReason;
  final double totalSales;
  final int totalOrders;
  final int cancelledOrders;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Shift({
    required this.id,
    required this.shiftType,
    required this.shiftDate,
    required this.openedByUserId,
    required this.openedAt,
    required this.openingCash,
    this.openingCashAdjustment,
    this.openingCashAdjustmentReason,
    this.openingCashAdjustedByUserId,
    this.closedByUserId,
    this.closedAt,
    this.expectedClosingCash = 0,
    this.actualClosingCash = 0,
    this.cashVariance = 0,
    this.cashVarianceReason,
    this.totalSales = 0,
    this.totalOrders = 0,
    this.cancelledOrders = 0,
    this.status = 'active',
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        shiftType,
        shiftDate,
        openedByUserId,
        openedAt,
        openingCash,
        openingCashAdjustment,
        openingCashAdjustmentReason,
        openingCashAdjustedByUserId,
        closedByUserId,
        closedAt,
        expectedClosingCash,
        actualClosingCash,
        cashVariance,
        cashVarianceReason,
        totalSales,
        totalOrders,
        cancelledOrders,
        status,
        createdAt,
        updatedAt,
      ];

  bool get isActive => status == 'active';
  bool get isClosed => status == 'closed';
  bool get isMorning => shiftType == 'morning';
  bool get isEvening => shiftType == 'evening';

  /// Get final opening cash (including adjustment)
  double get finalOpeningCash {
    return openingCash + (openingCashAdjustment ?? 0);
  }

  /// Calculate expected closing cash
  static double calculateExpectedClosingCash(
    double openingCash,
    double totalSales,
  ) {
    return openingCash + totalSales;
  }

  /// Calculate cash variance
  static double calculateCashVariance(
    double actualClosingCash,
    double expectedClosingCash,
  ) {
    return actualClosingCash - expectedClosingCash;
  }

  Shift copyWith({
    String? id,
    String? shiftType,
    DateTime? shiftDate,
    String? openedByUserId,
    DateTime? openedAt,
    double? openingCash,
    double? openingCashAdjustment,
    String? openingCashAdjustmentReason,
    String? openingCashAdjustedByUserId,
    String? closedByUserId,
    DateTime? closedAt,
    double? expectedClosingCash,
    double? actualClosingCash,
    double? cashVariance,
    String? cashVarianceReason,
    double? totalSales,
    int? totalOrders,
    int? cancelledOrders,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Shift(
      id: id ?? this.id,
      shiftType: shiftType ?? this.shiftType,
      shiftDate: shiftDate ?? this.shiftDate,
      openedByUserId: openedByUserId ?? this.openedByUserId,
      openedAt: openedAt ?? this.openedAt,
      openingCash: openingCash ?? this.openingCash,
      openingCashAdjustment: openingCashAdjustment ?? this.openingCashAdjustment,
      openingCashAdjustmentReason:
          openingCashAdjustmentReason ?? this.openingCashAdjustmentReason,
      openingCashAdjustedByUserId:
          openingCashAdjustedByUserId ?? this.openingCashAdjustedByUserId,
      closedByUserId: closedByUserId ?? this.closedByUserId,
      closedAt: closedAt ?? this.closedAt,
      expectedClosingCash: expectedClosingCash ?? this.expectedClosingCash,
      actualClosingCash: actualClosingCash ?? this.actualClosingCash,
      cashVariance: cashVariance ?? this.cashVariance,
      cashVarianceReason: cashVarianceReason ?? this.cashVarianceReason,
      totalSales: totalSales ?? this.totalSales,
      totalOrders: totalOrders ?? this.totalOrders,
      cancelledOrders: cancelledOrders ?? this.cancelledOrders,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
