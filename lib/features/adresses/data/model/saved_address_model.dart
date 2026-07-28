import 'package:ecommerce/features/adresses/domain/entity/saved_address_entity.dart';

class SavedAddressModel extends SavedAddressEntity {
  const SavedAddressModel({
    required super.id,
    required super.name,
    required super.details,
    required super.phone,
    required super.city,
  });

  factory SavedAddressModel.fromJson(Map<String, dynamic> json) {
    return SavedAddressModel(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      details: json['details'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'details': details,
      'phone': phone,
      'city': city,
    };
  }
}