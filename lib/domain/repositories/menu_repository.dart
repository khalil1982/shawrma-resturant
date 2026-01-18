import 'package:dartz/dartz.dart';
import '../../core/errors/failures.dart';
import '../entities/menu_item.dart';

/// Menu repository interface
abstract class MenuRepository {
  /// Get all active menu items
  Future<Either<Failure, List<MenuItem>>> getActiveMenuItems();

  /// Get menu item by ID
  Future<Either<Failure, MenuItem>> getMenuItemById(String id);

  /// Search menu items by name
  Future<Either<Failure, List<MenuItem>>> searchMenuItems(String query);
}
