
import 'package:ecommerce/features/adresses/domain/entity/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.status,
    required super.message,
    required List<AddressItemModel> super.data,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => AddressItemModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data
          .map((e) => (e as AddressItemModel).toJson())
          .toList(),
    };
  }
}

class AddressItemModel extends AddressItemEntity {
  const AddressItemModel({
    required super.id,
    required super.name,
    required super.details,
    required super.phone,
    required super.city,
  });

  factory AddressItemModel.fromJson(Map<String, dynamic> json) {
    return AddressItemModel(
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