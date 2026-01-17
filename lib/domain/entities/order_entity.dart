import '../../core/constants/enums.dart';
import 'order_item_entity.dart';

/// كيان الطلب - Domain Layer
class OrderEntity {
  final int id;
  final String orderNumber;
  final int userId;
  final String cashierName;
  final double subtotal;
  final double discount;
  final double total;
  final OrderStatus status;
  final PaymentMethod? paymentMethod;
  final String? customerName;
  final String? notes;
  final DateTime createdAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  final List<OrderItemEntity> items;

  const OrderEntity({
    required this.id,
    required this.orderNumber,
    required this.userId,
    required this.cashierName,
    required this.subtotal,
    required this.discount,
    required this.total,
    required this.status,
    this.paymentMethod,
    this.customerName,
    this.notes,
    required this.createdAt,
    this.completedAt,
    this.cancelledAt,
    required this.items,
  });

  /// عدد الأصناف
  int get itemsCount => items.length;

  /// إجمالي الكمية
  int get totalQuantity => items.fold(0, (sum, item) => sum + item.quantity);

  /// هل الطلب مكتمل؟
  bool get isCompleted => status == OrderStatus.completed;

  /// هل الطلب ملغي؟
  bool get isCancelled => status == OrderStatus.cancelled;

  /// هل الطلب نشط؟
  bool get isActive =>
      status != OrderStatus.completed && status != OrderStatus.cancelled;

  OrderEntity copyWith({
    int? id,
    String? orderNumber,
    int? userId,
    String? cashierName,
    double? subtotal,
    double? discount,
    double? total,
    OrderStatus? status,
    PaymentMethod? paymentMethod,
    String? customerName,
    String? notes,
    DateTime? createdAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    List<OrderItemEntity>? items,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      orderNumber: orderNumber ?? this.orderNumber,
      userId: userId ?? this.userId,
      cashierName: cashierName ?? this.cashierName,
      subtotal: subtotal ?? this.subtotal,
      discount: discount ?? this.discount,
      total: total ?? this.total,
      status: status ?? this.status,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      customerName: customerName ?? this.customerName,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      items: items ?? this.items,
    );
  }
}
