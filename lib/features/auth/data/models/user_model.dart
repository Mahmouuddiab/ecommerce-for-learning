import 'package:ecommerce/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.message,
    required UserDataModel super.user,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'] as String? ?? '',
      user: UserDataModel.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
      token: json['token'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'user': (user as UserDataModel).toJson(),
      'token': token,
    };
  }
}

class UserDataModel extends UserDataEntity {
  const UserDataModel({
    required super.name,
    required super.email,
    required super.role,
  });

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      role: json['role'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'role': role};
  }
}
