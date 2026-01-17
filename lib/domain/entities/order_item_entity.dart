/// كيان عنصر الطلب - Domain Layer
class OrderItemEntity {
  final int id;
  final int orderId;
  final int itemId;
  final String itemName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final String? notes;

  const OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.itemId,
    required this.itemName,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    this.notes,
  });

  OrderItemEntity copyWith({
    int? id,
    int? orderId,
    int? itemId,
    String? itemName,
    int? quantity,
    double? unitPrice,
    double? totalPrice,
    String? notes,
  }) {
    return OrderItemEntity(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      itemId: itemId ?? this.itemId,
      itemName: itemName ?? this.itemName,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      totalPrice: totalPrice ?? this.totalPrice,
      notes: notes ?? this.notes,
    );
  }
}
