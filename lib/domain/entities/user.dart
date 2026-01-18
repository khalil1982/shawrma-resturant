import 'package:equatable/equatable.dart';

/// User entity
class User extends Equatable {
  final String id;
  final String username;
  final String fullName;
  final String role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        fullName,
        role,
        isActive,
        createdAt,
        updatedAt,
      ];

  bool get isOwner => role == 'owner';
  bool get isCashier => role == 'cashier';
  bool get isKitchen => role == 'kitchen';
}
