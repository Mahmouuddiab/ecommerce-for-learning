import 'package:equatable/equatable.dart';

class ReviewEntity extends Equatable {
  final String id;
  final String review;
  final int rating;
  final String productId;
  final String userId;
  final String userName; // Added to easily show user names in UI
  final DateTime createdAt;
  final DateTime updatedAt;

  const ReviewEntity({
    required this.id,
    required this.review,
    required this.rating,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ReviewEntity.fromJson(Map<String, dynamic> json) {
    // 1. Extract user data safely (whether it's a Map or String ID)
    String parsedUserId = '';
    String parsedUserName = 'Anonymous';

    if (json['user'] is Map<String, dynamic>) {
      parsedUserId = json['user']['_id'] ?? '';
      parsedUserName = json['user']['name'] ?? 'Anonymous';
    } else if (json['user'] is String) {
      parsedUserId = json['user'] as String;
    }

    // 2. Parse dates safely
    final created = json['createdAt'] != null
        ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
        : DateTime.now();

    final updated = json['updatedAt'] != null
        ? DateTime.tryParse(json['updatedAt']) ?? DateTime.now()
        : DateTime.now();

    return ReviewEntity(
      id: json['_id'] ?? '',
      review: json['review'] ?? '',
      rating: (json['rating'] as num?)?.toInt() ?? 0,
      productId: json['product'] ?? '',
      userId: parsedUserId,
      userName: parsedUserName,
      createdAt: created,
      updatedAt: updated,
    );
  }

  @override
  List<Object?> get props => [
    id,
    review,
    rating,
    productId,
    userId,
    userName,
    createdAt,
    updatedAt,
  ];
}