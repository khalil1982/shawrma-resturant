import 'package:equatable/equatable.dart';
import 'order_item.dart';

/// Order entity
class Order extends Equatable {
  final String id;
  final String orderNumber;
  final String shiftId;
  final String orderType;
  final int customerCount;
  final String status;
  final double subtotal;
  final double discountAmount;
  final double totalAmount;
  final String paymentMethod;
  final double amountPaid;
  final double changeAmount;
  final String? notes;
  final List<OrderItem> items;
  final String createdByUserId;
  final DateTime createdAt;
  final String? completedByUserId;
  final DateTime? completedAt;
  final String? cancelledByUserId;
  final DateTime? cancelledAt;
  final String? cancellationReason;
  final DateTime updatedAt;

  const Order({
    required this.id,
    required this.orderNumber,
    required this.shiftId,
    required this.orderType,
    required this.customerCount,
    required this.status,
    required this.subtotal,
    this.discountAmount = 0,
    required this.totalAmount,
    this.paymentMethod = 'cash',
    this.amountPaid = 0,
    this.changeAmount = 0,
    this.notes,
    this.items = const [],
    required this.createdByUserId,
    required this.createdAt,
    this.completedByUserId,
    this.completedAt,
    this.cancelledByUserId,
    this.cancelledAt,
    this.cancellationReason,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        orderNumber,
        shiftId,
        orderType,
        customerCount,
        status,
        subtotal,
        discountAmount,
        totalAmount,
        paymentMethod,
        amountPaid,
        changeAmount,
        notes,
        items,
        createdByUserId,
        createdAt,
        completedByUserId,
        completedAt,
        cancelledByUserId,
        cancelledAt,
        cancellationReason,
        updatedAt,
      ];

  bool get isPending => status == 'pending';
  bool get isPreparing => status == 'preparing';
  bool get isReady => status == 'ready';
  bool get isDelivered => status == 'delivered';
  bool get isCancelled => status == 'cancelled';
  bool get isDineIn => orderType == 'dine_in';
  bool get isTakeaway => orderType == 'takeaway';

  /// Calculate total from items
  static double calculateSubtotal(List<OrderItem> items) {
    return items.fold(0.0, (sum, item) => sum + item.subtotal);
  }

  /// Calculate total amount after discount
  static double calculateTotalAmount(double subtotal, double discountAmount) {
    return subtotal - discountAmount;
  }

  /// Calculate change
  static double calculateChange(double amountPaid, double totalAmount) {
    return amountPaid - totalAmount;
  }

  Order copyWith({
    String? id,
    String? orderNumber,
    String? shiftId,
    String? orderType,
    int? customerCount,
    String? status,
    double? subtotal,
    double? discountAmount,
    double? totalAmount,
    String? paymentMethod,
    double? amountPaid,
    double? changeAmount,
    String? notes,
    List<OrderItem>? items,
    String? createdByUserId,
    DateTime? createdAt,
    String? completedByUserId,
    DateTime? completedAt,
    String? cancelledByUserId,
    DateTime? cancelledAt,
    String? cancellationReason,
    DateTime? updatedAt,
  }) {
    return Order(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      shiftId: shiftId ?? this.shiftId,
      orderType: orderType ?? this.orderType,
      customerCount: customerCount ?? this.customerCount,
      status: status ?? this.status,
      subtotal: subtotal ?? this.subtotal,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amountPaid: amountPaid ?? this.amountPaid,
      changeAmount: changeAmount ?? this.changeAmount,
      notes: notes ?? this.notes,
      items: items ?? this.items,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      completedByUserId: completedByUserId ?? this.completedByUserId,
      completedAt: completedAt ?? this.completedAt,
      cancelledByUserId: cancelledByUserId ?? this.cancelledByUserId,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
