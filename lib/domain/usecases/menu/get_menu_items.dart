import 'package:dartz/dartz.dart';
import '../../../core/errors/failures.dart';
import '../../entities/menu_item.dart';
import '../../repositories/menu_repository.dart';

/// Use case for getting active menu items
class GetMenuItems {
  final MenuRepository repository;

  GetMenuItems(this.repository);

  Future<Either<Failure, List<MenuItem>>> call() async {
    return await repository.getActiveMenuItems();
  }
}
