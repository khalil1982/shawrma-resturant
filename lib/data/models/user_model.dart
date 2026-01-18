import '../../domain/entities/user.dart';
import '../../core/utils/date_utils.dart';

/// User model extending User entity with database conversion
class UserModel extends User {
  const UserModel({
    required super.id,
    required super.username,
    required super.fullName,
    required super.role,
    required super.isActive,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Create UserModel from User entity
  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      username: user.username,
      fullName: user.fullName,
      role: user.role,
      isActive: user.isActive,
      createdAt: user.createdAt,
      updatedAt: user.updatedAt,
    );
  }

  /// Create UserModel from database map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      username: map['username'] as String,
      fullName: map['full_name'] as String,
      role: map['role'] as String,
      isActive: (map['is_active'] as int) == 1,
      createdAt: AppDateUtils.fromDbFormat(map['created_at'] as String),
      updatedAt: AppDateUtils.fromDbFormat(map['updated_at'] as String),
    );
  }

  /// Convert UserModel to database map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'full_name': fullName,
      'role': role,
      'is_active': isActive ? 1 : 0,
      'created_at': AppDateUtils.toDbFormat(createdAt),
      'updated_at': AppDateUtils.toDbFormat(updatedAt),
    };
  }
}
