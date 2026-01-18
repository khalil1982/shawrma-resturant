import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/order.dart';
import '../entities/order_item.dart';

/// Order repository interface
abstract class OrderRepository {
  /// Create a new order
  Future<Either<Failure, Order>> createOrder({
    required String shiftId,
    required String orderType,
    required int customerCount,
    required String createdByUserId,
    String? notes,
  });

  /// Get order by ID with items
  Future<Either<Failure, Order>> getOrderById(String id);

  /// Get all orders for a shift
  Future<Either<Failure, List<Order>>> getOrdersByShift(String shiftId);

  /// Add item to order
  Future<Either<Failure, Order>> addItemToOrder({
    required String orderId,
    required String menuItemId,
    required String itemName,
    required double itemPrice,
    required int quantity,
    String? notes,
  });

  /// Update order item quantity
  Future<Either<Failure, Order>> updateOrderItemQuantity({
    required String orderId,
    required String orderItemId,
    required int newQuantity,
  });

  /// Remove item from order
  Future<Either<Failure, Order>> removeItemFromOrder({
    required String orderId,
    required String orderItemId,
  });

  /// Update order status
  Future<Either<Failure, Order>> updateOrderStatus({
    required String orderId,
    required String status,
  });

  /// Complete order (payment)
  Future<Either<Failure, Order>> completeOrder({
    required String orderId,
    required String completedByUserId,
    required String paymentMethod,
    required double amountPaid,
  });

  /// Cancel order
  Future<Either<Failure, Order>> cancelOrder({
    required String orderId,
    required String cancelledByUserId,
    String? cancellationReason,
  });

  /// Get order items for an order
  Future<Either<Failure, List<OrderItem>>> getOrderItems(String orderId);
}
