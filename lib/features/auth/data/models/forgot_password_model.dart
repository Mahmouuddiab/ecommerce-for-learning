import 'package:ecommerce/features/auth/domain/entities/forgot_password.dart';

class ForgotPasswordModel extends ForgotPasswordEntity {
  const ForgotPasswordModel({
    required super.statusMsg,
    required super.message,
  });

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordModel(
      statusMsg: json['statusMsg'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'statusMsg': statusMsg,
      'message': message,
    };
  }
}