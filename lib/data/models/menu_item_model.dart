import '../../domain/entities/menu_item.dart';
import '../../core/utils/date_utils.dart';

/// MenuItem model extending MenuItem entity with database conversion
class MenuItemModel extends MenuItem {
  const MenuItemModel({
    required super.id,
    required super.name,
    required super.price,
    super.category,
    required super.isActive,
    required super.displayOrder,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create MenuItemModel from MenuItem entity
  factory MenuItemModel.fromEntity(MenuItem item) {
    return MenuItemModel(
      id: item.id,
      name: item.name,
      price: item.price,
      category: item.category,
      isActive: item.isActive,
      displayOrder: item.displayOrder,
      createdAt: item.createdAt,
      updatedAt: item.updatedAt,
    );
  }

  /// Create MenuItemModel from database map
  factory MenuItemModel.fromMap(Map<String, dynamic> map) {
    return MenuItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      category: map['category'] as String?,
      isActive: (map['is_active'] as int) == 1,
      displayOrder: map['display_order'] as int,
      createdAt: AppDateUtils.fromDbFormat(map['created_at'] as String),
      updatedAt: AppDateUtils.fromDbFormat(map['updated_at'] as String),
    );
  }

  /// Convert MenuItemModel to database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'category': category,
      'is_active': isActive ? 1 : 0,
      'display_order': displayOrder,
      'created_at': AppDateUtils.toDbFormat(createdAt),
      'updated_at': AppDateUtils.toDbFormat(updatedAt),
    };
  }
}
