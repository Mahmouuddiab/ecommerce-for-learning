import 'package:ecommerce/features/auth/domain/entities/verify_code_entity.dart';

class VerifyCodeModel extends VerifyCodeEntity {
  const VerifyCodeModel({
    required super.status,
  });

  factory VerifyCodeModel.fromJson(Map<String, dynamic> json) {
    return VerifyCodeModel(
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }
}