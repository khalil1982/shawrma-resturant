/// كيان الفئة - Domain Layer
class CategoryEntity {
  final int id;
  final String name;
  final String? description;
  final int displayOrder;
  final bool isActive;

  const CategoryEntity({
    required this.id,
    required this.name,
    this.description,
    required this.displayOrder,
    required this.isActive,
  });

  CategoryEntity copyWith({
    int? id,
    String? name,
    String? description,
    int? displayOrder,
    bool? isActive,
  }) {
    return CategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      displayOrder: displayOrder ?? this.displayOrder,
      isActive: isActive ?? this.isActive,
    );
  }
}
