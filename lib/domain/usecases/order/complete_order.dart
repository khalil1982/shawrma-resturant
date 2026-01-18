import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/order.dart';
import '../../repositories/order_repository.dart';
import '../../repositories/shift_repository.dart';

/// Parameters for completing an order
class CompleteOrderParams {
  final String orderId;
  final String completedByUserId;
  final String paymentMethod;
  final double amountPaid;

  CompleteOrderParams({
    required this.orderId,
    required this.completedByUserId,
    this.paymentMethod = 'cash',
    required this.amountPaid,
  });
}

/// Use case for completing an order (payment)
class CompleteOrder {
  final OrderRepository orderRepository;
  final ShiftRepository shiftRepository;

  CompleteOrder(this.orderRepository, this.shiftRepository);

  Future<Either<Failure, Order>> call(CompleteOrderParams params) async {
    // 1. Get the order
    final orderResult = await orderRepository.getOrderById(params.orderId);
    if (orderResult.isLeft()) {
      return Left(
        orderResult.fold((failure) => failure, (_) => throw Exception()),
      );
    }

    final order = orderResult.getOrElse(() => throw Exception());

    // 2. Validate order status
    if (order.isDelivered) {
      return const Left(BusinessLogicFailure('الطلب مكتمل بالفعل'));
    }
    if (order.isCancelled) {
      return const Left(BusinessLogicFailure('الطلب ملغي ولا يمكن إكماله'));
    }

    // 3. Validate payment amount
    if (params.amountPaid < order.totalAmount) {
      return const Left(
        ValidationFailure('المبلغ المدفوع يجب أن يكون على الأقل مساوٍ للمبلغ المستحق'),
      );
    }

    // 4. Complete the order
    final result = await orderRepository.completeOrder(
      orderId: params.orderId,
      completedByUserId: params.completedByUserId,
      paymentMethod: params.paymentMethod,
      amountPaid: params.amountPaid,
    );

    // 5. Update shift statistics if successful
    if (result.isRight()) {
      final completedOrder = result.getOrElse(() => throw Exception());
      await shiftRepository.updateShiftStatistics(
        shiftId: completedOrder.shiftId,
        totalSales: completedOrder.totalAmount,
        totalOrders: 1,
      );
    }

    return result;
  }
}
