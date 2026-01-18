import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/order.dart';
import '../../repositories/order_repository.dart';
import '../../repositories/shift_repository.dart';

/// Parameters for creating an order
class CreateOrderParams {
  final String shiftId;
  final String orderType;
  final int customerCount;
  final String createdByUserId;
  final String? notes;

  CreateOrderParams({
    required this.shiftId,
    required this.orderType,
    this.customerCount = 1,
    required this.createdByUserId,
    this.notes,
  });
}

/// Use case for creating a new order
class CreateOrder {
  final OrderRepository orderRepository;
  final ShiftRepository shiftRepository;

  CreateOrder(this.orderRepository, this.shiftRepository);

  Future<Either<Failure, Order>> call(CreateOrderParams params) async {
    // 1. Validate there's an active shift
    final activeShiftResult = await shiftRepository.getActiveShift();
    if (activeShiftResult.isLeft()) {
      return Left(
        activeShiftResult.fold((failure) => failure, (_) => throw Exception()),
      );
    }

    final activeShift = activeShiftResult.getOrElse(() => null);
    if (activeShift == null) {
      return const Left(
        BusinessLogicFailure('لا توجد وردية نشطة. يجب فتح وردية أولاً'),
      );
    }

    // 2. Validate order type
    if (params.orderType != 'dine_in' && params.orderType != 'takeaway') {
      return const Left(ValidationFailure('نوع الطلب غير صحيح'));
    }

    // 3. Validate customer count
    if (params.customerCount < 1) {
      return const Left(ValidationFailure('عدد الأشخاص يجب أن يكون على الأقل 1'));
    }

    // 4. Create the order
    return await orderRepository.createOrder(
      shiftId: activeShift.id,
      orderType: params.orderType,
      customerCount: params.customerCount,
      createdByUserId: params.createdByUserId,
      notes: params.notes,
    );
  }
}
