import 'package:ecommerce/features/profile/domain/entities/profile_entity.dart';

class ProfileModel extends ProfileEntity {
  const ProfileModel({
    required super.id,
    required super.role,
    required super.active,
    required super.wishlist,
    required super.name,
    required super.email,
    required super.phone,
    required super.addresses,
    required super.createdAt,
    required super.updatedAt,
  });

  /// Factory constructor to parse JSON into ProfileModel
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    // Safely handles both root response `{"data": {...}}` and nested object
    final data = json.containsKey('data') ? json['data'] : json;

    return ProfileModel(
      id: data['_id'] as String? ?? '',
      role: data['role'] as String? ?? '',
      active: data['active'] as bool? ?? false,
      wishlist: List<dynamic>.from(data['wishlist'] ?? []),
      name: data['name'] as String? ?? '',
      email: data['email'] as String? ?? '',
      phone: data['phone'] as String? ?? '',
      addresses: List<dynamic>.from(data['addresses'] ?? []),
      createdAt: DateTime.parse(data['createdAt']),
      updatedAt: DateTime.parse(data['updatedAt']),
    );
  }

  /// Converts ProfileModel back to JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'role': role,
      'active': active,
      'wishlist': wishlist,
      'name': name,
      'email': email,
      'phone': phone,
      'addresses': addresses,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}