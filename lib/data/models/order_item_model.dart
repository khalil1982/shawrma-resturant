import '../../domain/entities/order_item.dart';
import '../../core/utils/date_utils.dart';

/// OrderItem model extending OrderItem entity with database conversion
class OrderItemModel extends OrderItem {
  const OrderItemModel({
    required super.id,
    required super.orderId,
    required super.menuItemId,
    required super.itemName,
    required super.itemPrice,
    required super.quantity,
    required super.subtotal,
    super.notes,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create OrderItemModel from OrderItem entity
  factory OrderItemModel.fromEntity(OrderItem item) {
    return OrderItemModel(
      id: item.id,
      orderId: item.orderId,
      menuItemId: item.menuItemId,
      itemName: item.itemName,
      itemPrice: item.itemPrice,
      quantity: item.quantity,
      subtotal: item.subtotal,
      notes: item.notes,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );
  }

  /// Create OrderItemModel from database map
  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      id: map['id'] as String,
      orderId: map['order_id'] as String,
      menuItemId: map['menu_item_id'] as String,
      itemName: map['item_name'] as String,
      itemPrice: (map['item_price'] as num).toDouble(),
      quantity: map['quantity'] as int,
      subtotal: (map['subtotal'] as num).toDouble(),
      notes: map['notes'] as String?,
      createdAt: AppDateUtils.fromDbFormat(map['created_at'] as String),
      updatedAt: AppDateUtils.fromDbFormat(map['updated_at'] as String),
    );
  }

  /// Convert OrderItemModel to database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order_id': orderId,
      'menu_item_id': menuItemId,
      'item_name': itemName,
      'item_price': itemPrice,
      'quantity': quantity,
      'subtotal': subtotal,
      'notes': notes,
      'created_at': AppDateUtils.toDbFormat(createdAt),
      'updated_at': AppDateUtils.toDbFormat(updatedAt),
    };
  }
}
