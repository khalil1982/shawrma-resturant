import '../../core/constants/enums.dart';

/// كيان المستخدم - Domain Layer
class UserEntity {
  final int id;
  final String username;
  final String fullName;
  final UserRole role;
  final bool isActive;

  const UserEntity({
    required this.id,
    required this.username,
    required this.fullName,
    required this.role,
    required this.isActive,
  });

  /// نسخ مع تعديلات
  UserEntity copyWith({
    int? id,
    String? username,
    String? fullName,
    UserRole? role,
    bool? isActive,
  }) {
    return UserEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
        other.id == id &&
        other.username == username &&
        other.fullName == fullName &&
        other.role == role &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        fullName.hashCode ^
        role.hashCode ^
        isActive.hashCode;
  }
}
