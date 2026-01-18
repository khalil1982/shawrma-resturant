import '../../domain/entities/order.dart';
import '../../domain/entities/order_item.dart';
import '../../core/utils/date_utils.dart';
import 'order_item_model.dart';

/// Order model extending Order entity with database conversion
class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.orderNumber,
    required super.shiftId,
    required super.orderType,
    required super.customerCount,
    required super.status,
    required super.subtotal,
    super.discountAmount,
    required super.totalAmount,
    super.paymentMethod,
    super.amountPaid,
    super.changeAmount,
    super.notes,
    super.items,
    required super.createdByUserId,
    required super.createdAt,
    super.completedByUserId,
    super.completedAt,
    super.cancelledByUserId,
    super.cancelledAt,
    super.cancellationReason,
    required super.updatedAt,
  });

  /// Create OrderModel from Order entity
  factory OrderModel.fromEntity(Order order) {
    return OrderModel(
      id: order.id,
      orderNumber: order.orderNumber,
      shiftId: order.shiftId,
      orderType: order.orderType,
      customerCount: order.customerCount,
      status: order.status,
      subtotal: order.subtotal,
      discountAmount: order.discountAmount,
      totalAmount: order.totalAmount,
      paymentMethod: order.paymentMethod,
      amountPaid: order.amountPaid,
      changeAmount: order.changeAmount,
      notes: order.notes,
      items: order.items,
      createdByUserId: order.createdByUserId,
      createdAt: order.createdAt,
      completedByUserId: order.completedByUserId,
      completedAt: order.completedAt,
      cancelledByUserId: order.cancelledByUserId,
      cancelledAt: order.cancelledAt,
      cancellationReason: order.cancellationReason,
      updatedAt: order.updatedAt,
    );
  }

  /// Create OrderModel from database map
  factory OrderModel.fromMap(
    Map<String, dynamic> map, {
    List<OrderItem>? items,
  }) {
    return OrderModel(
      id: map['id'] as String,
      orderNumber: map['order_number'] as String,
      shiftId: map['shift_id'] as String,
      orderType: map['order_type'] as String,
      customerCount: map['customer_count'] as int,
      status: map['status'] as String,
      subtotal: (map['subtotal'] as num).toDouble(),
      discountAmount: (map['discount_amount'] as num).toDouble(),
      totalAmount: (map['total_amount'] as num).toDouble(),
      paymentMethod: map['payment_method'] as String,
      amountPaid: (map['amount_paid'] as num).toDouble(),
      changeAmount: (map['change_amount'] as num).toDouble(),
      notes: map['notes'] as String?,
      items: items ?? [],
      createdByUserId: map['created_by_user_id'] as String,
      createdAt: AppDateUtils.fromDbFormat(map['created_at'] as String),
      completedByUserId: map['completed_by_user_id'] as String?,
      completedAt: map['completed_at'] != null
          ? AppDateUtils.fromDbFormat(map['completed_at'] as String)
          : null,
      cancelledByUserId: map['cancelled_by_user_id'] as String?,
      cancelledAt: map['cancelled_at'] != null
          ? AppDateUtils.fromDbFormat(map['cancelled_at'] as String)
          : null,
      cancellationReason: map['cancellation_reason'] as String?,
      updatedAt: AppDateUtils.fromDbFormat(map['updated_at'] as String),
    );
  }

  /// Convert OrderModel to database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_number': orderNumber,
      'shift_id': shiftId,
      'order_type': orderType,
      'customer_count': customerCount,
      'status': status,
      'subtotal': subtotal,
      'discount_amount': discountAmount,
      'total_amount': totalAmount,
      'payment_method': paymentMethod,
      'amount_paid': amountPaid,
      'change_amount': changeAmount,
      'notes': notes,
      'created_by_user_id': createdByUserId,
      'created_at': AppDateUtils.toDbFormat(createdAt),
      'completed_by_user_id': completedByUserId,
      'completed_at':
          completedAt != null ? AppDateUtils.toDbFormat(completedAt!) : null,
      'cancelled_by_user_id': cancelledByUserId,
      'cancelled_at':
          cancelledAt != null ? AppDateUtils.toDbFormat(cancelledAt!) : null,
      'cancellation_reason': cancellationReason,
      'updated_at': AppDateUtils.toDbFormat(updatedAt),
    };
  }
}
