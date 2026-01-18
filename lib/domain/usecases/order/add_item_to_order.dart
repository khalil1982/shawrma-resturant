import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/order.dart';
import '../../repositories/order_repository.dart';
import '../../repositories/menu_repository.dart';

/// Parameters for adding item to order
class AddItemToOrderParams {
  final String orderId;
  final String menuItemId;
  final int quantity;
  final String? notes;

  AddItemToOrderParams({
    required this.orderId,
    required this.menuItemId,
    this.quantity = 1,
    this.notes,
  });
}

/// Use case for adding an item to an order
class AddItemToOrder {
  final OrderRepository orderRepository;
  final MenuRepository menuRepository;

  AddItemToOrder(this.orderRepository, this.menuRepository);

  Future<Either<Failure, Order>> call(AddItemToOrderParams params) async {
    // 1. Validate quantity
    if (params.quantity < 1) {
      return const Left(ValidationFailure('الكمية يجب أن تكون على الأقل 1'));
    }

    // 2. Get the menu item
    final menuItemResult = await menuRepository.getMenuItemById(
      params.menuItemId,
    );
    if (menuItemResult.isLeft()) {
      return Left(
        menuItemResult.fold((failure) => failure, (_) => throw Exception()),
      );
    }

    final menuItem = menuItemResult.getOrElse(() => throw Exception());

    // 3. Validate menu item is active
    if (!menuItem.isActive) {
      return const Left(BusinessLogicFailure('هذا الصنف غير متاح حالياً'));
    }

    // 4. Add item to order
    return await orderRepository.addItemToOrder(
      orderId: params.orderId,
      menuItemId: menuItem.id,
      itemName: menuItem.name,
      itemPrice: menuItem.price,
      quantity: params.quantity,
      notes: params.notes,
    );
  }
}
