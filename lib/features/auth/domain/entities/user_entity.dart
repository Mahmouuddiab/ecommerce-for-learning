class UserEntity {
  final String message;
  final UserDataEntity user;
  final String token;

  const UserEntity({
    required this.message,
    required this.user,
    required this.token,
  });
}

/// Inner entity representing the specific user profile data.
class UserDataEntity {
  final String name;
  final String email;
  final String role;

  const UserDataEntity({
    required this.name,
    required this.email,
    required this.role,
  });
}