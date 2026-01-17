import '../../../core/constants/db_constants.dart';
import '../../../core/constants/enums.dart';
import '../../../domain/entities/user_entity.dart';

/// نموذج المستخدم - Data Layer
class UserModel {
  final int? id;
  final String username;
  final String passwordHash;
  final String fullName;
  final UserRole role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserModel({
    this.id,
    required this.username,
    required this.passwordHash,
    required this.fullName,
    required this.role,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  /// من Map إلى Model
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map[DbConstants.usersId] as int?,
      username: map[DbConstants.usersUsername] as String,
      passwordHash: map[DbConstants.usersPasswordHash] as String,
      fullName: map[DbConstants.usersFullName] as String,
      role: UserRole.fromString(map[DbConstants.usersRole] as String),
      isActive: (map[DbConstants.usersIsActive] as int) == 1,
      createdAt: DateTime.parse(map[DbConstants.usersCreatedAt] as String),
      updatedAt: DateTime.parse(map[DbConstants.usersUpdatedAt] as String),
    );
  }

  /// من Model إلى Map
  Map<String, dynamic> toMap() {
    return {
      if (id != null) DbConstants.usersId: id,
      DbConstants.usersUsername: username,
      DbConstants.usersPasswordHash: passwordHash,
      DbConstants.usersFullName: fullName,
      DbConstants.usersRole: role.value,
      DbConstants.usersIsActive: isActive ? 1 : 0,
      DbConstants.usersCreatedAt: createdAt.toIso8601String(),
      DbConstants.usersUpdatedAt: updatedAt.toIso8601String(),
    };
  }

  /// من Model إلى Entity
  UserEntity toEntity() {
    return UserEntity(
      id: id!,
      username: username,
      fullName: fullName,
      role: role,
      isActive: isActive,
    );
  }

  /// من Entity إلى Model
  factory UserModel.fromEntity(UserEntity entity, String passwordHash) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      passwordHash: passwordHash,
      fullName: entity.fullName,
      role: entity.role,
      isActive: entity.isActive,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  /// نسخ مع تعديلات
  UserModel copyWith({
    int? id,
    String? username,
    String? passwordHash,
    String? fullName,
    UserRole? role,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      passwordHash: passwordHash ?? this.passwordHash,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
