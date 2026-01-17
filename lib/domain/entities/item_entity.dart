/// كيان الصنف - Domain Layer
class ItemEntity {
  final int id;
  final String name;
  final int categoryId;
  final String categoryName;
  final double sellPrice;
  final double costPrice;
  final String? description;
  final String? imagePath;
  final bool isActive;

  const ItemEntity({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categoryName,
    required this.sellPrice,
    required this.costPrice,
    this.description,
    this.imagePath,
    required this.isActive,
  });

  /// هامش الربح
  double get profitMargin => sellPrice - costPrice;

  /// نسبة الربح المئوية
  double get profitPercentage =>
      costPrice > 0 ? ((profitMargin / costPrice) * 100) : 0;

  ItemEntity copyWith({
    int? id,
    String? name,
    int? categoryId,
    String? categoryName,
    double? sellPrice,
    double? costPrice,
    String? description,
    String? imagePath,
    bool? isActive,
  }) {
    return ItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      sellPrice: sellPrice ?? this.sellPrice,
      costPrice: costPrice ?? this.costPrice,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      isActive: isActive ?? this.isActive,
    );
  }
}
