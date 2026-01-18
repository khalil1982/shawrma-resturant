import 'package:equatable/equatable.dart';

/// Menu item entity
class MenuItem extends Equatable {
  final String id;
  final String name;
  final double price;
  final String? category;
  final bool isActive;
  final int displayOrder;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.category,
    required this.isActive,
    required this.displayOrder,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        category,
        isActive,
        displayOrder,
        createdAt,
        updatedAt,
      ];
}
