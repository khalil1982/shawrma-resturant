import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/order.dart';
import '../../repositories/order_repository.dart';
import '../../repositories/shift_repository.dart';

/// Parameters for cancelling an order
class CancelOrderParams {
  final String orderId;
  final String cancelledByUserId;
  final String? cancellationReason;

  CancelOrderParams({
    required this.orderId,
    required this.cancelledByUserId,
    this.cancellationReason,
  });
}

/// Use case for cancelling an order
class CancelOrder {
  final OrderRepository orderRepository;
  final ShiftRepository shiftRepository;

  CancelOrder(this.orderRepository, this.shiftRepository);

  Future<Either<Failure, Order>> call(CancelOrderParams params) async {
    // 1. Get the order
    final orderResult = await orderRepository.getOrderById(params.orderId);
    if (orderResult.isLeft()) {
      return Left(
        orderResult.fold((failure) => failure, (_) => throw Exception()),
      );
    }

    final order = orderResult.getOrElse(() => throw Exception());

    // 2. Validate order status
    if (order.isCancelled) {
      return const Left(BusinessLogicFailure('الطلب ملغي بالفعل'));
    }

    // Phase 1: Can only cancel before payment
    if (order.isDelivered) {
      return const Left(
        BusinessLogicFailure(
          'لا يمكن إلغاء الطلب بعد إتمام الدفع في المرحلة الأولى',
        ),
      );
    }

    // 3. Cancel the order
    final result = await orderRepository.cancelOrder(
      orderId: params.orderId,
      cancelledByUserId: params.cancelledByUserId,
      cancellationReason: params.cancellationReason,
    );

    // 4. Update shift statistics if successful
    if (result.isRight()) {
      final cancelledOrder = result.getOrElse(() => throw Exception());
      await shiftRepository.updateShiftStatistics(
        shiftId: cancelledOrder.shiftId,
        cancelledOrders: 1,
      );
    }

    return result;
  }
}
