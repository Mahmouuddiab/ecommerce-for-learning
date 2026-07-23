import 'package:ecommerce/features/wishlist/domain/entities/wishlist_response_entity.dart';

class WishlistResponseModel extends WishlistResponseEntity {
  const WishlistResponseModel({
    required super.status,
    required super.message,
    required super.data,
  });

  /// Convert JSON map into Model
  factory WishlistResponseModel.fromJson(Map<String, dynamic> json) {
    return WishlistResponseModel(
      status: json['status'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => item.toString())
          .toList() ??
          [],
    );
  }

  /// Convert Model instance into JSON map
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data,
    };
  }
}