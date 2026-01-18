import 'package:equatable/equatable.dart';

/// Order item entity
class OrderItem extends Equatable {
  final String id;
  final String orderId;
  final String menuItemId;
  final String itemName;
  final double itemPrice;
  final int quantity;
  final double subtotal;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  const OrderItem({
    required this.id,
    required this.orderId,
    required this.menuItemId,
    required this.itemName,
    required this.itemPrice,
    required this.quantity,
    required this.subtotal,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        orderId,
        menuItemId,
        itemName,
        itemPrice,
        quantity,
        subtotal,
        notes,
        createdAt,
        updatedAt,
      ];

  /// Calculate subtotal from price and quantity
  static double calculateSubtotal(double price, int quantity) {
    return price * quantity;
  }

  /// Create a copy with updated quantity
  OrderItem copyWith({
    String? id,
    String? orderId,
    String? menuItemId,
    String? itemName,
    double? itemPrice,
    int? quantity,
    double? subtotal,
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OrderItem(
      id: id ?? this.id,
      orderId: orderId ?? this.orderId,
      menuItemId: menuItemId ?? this.menuItemId,
      itemName: itemName ?? this.itemName,
      itemPrice: itemPrice ?? this.itemPrice,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
