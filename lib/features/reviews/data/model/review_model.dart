import 'package:ecommerce/features/reviews/domain/entity/review_entity.dart';

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.review,
    required super.rating,
    required super.productId,
    required super.userId,
    required super.createdAt,
    required super.updatedAt,
    required super.userName,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    // 1. Handle user nested object or string safely
    String parsedUserId = '';
    String parsedUserName = 'User';

    if (json['user'] is Map<String, dynamic>) {
      parsedUserId = json['user']['_id'] ?? '';
      parsedUserName = json['user']['name'] ?? 'User';
    } else if (json['user'] is String) {
      parsedUserId = json['user'] as String;
    }

    // 2. Parse dates safely without throwing runtime crashes
    final created = json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt'].toString()) ?? DateTime.now()
        : DateTime.now();

    final updated = json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt'].toString()) ?? DateTime.now()
        : DateTime.now();

    return ReviewModel(
      id: json['_id'] ?? '',
      review: json['review'] ?? '',
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      productId: json['product'] ?? '',
      userId: parsedUserId,
      userName: parsedUserName, // <-- Added this missing parameter
      createdAt: created,
      updatedAt: updated,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'review': review,
      'rating': rating,
      'product': productId,
      'user': {
        '_id': userId,
        'name': userName,
      },
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}