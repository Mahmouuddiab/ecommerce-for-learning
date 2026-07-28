import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String status;
  final String message;
  final List<AddressItemEntity> data;

  const AddressEntity({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [status, message, data];
}

class AddressItemEntity extends Equatable {
  final String id;
  final String name;
  final String details;
  final String phone;
  final String city;

  const AddressItemEntity({
    required this.id,
    required this.name,
    required this.details,
    required this.phone,
    required this.city,
  });

  @override
  List<Object?> get props => [id, name, details, phone, city];
}
