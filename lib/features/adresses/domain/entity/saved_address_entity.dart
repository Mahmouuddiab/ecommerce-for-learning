import 'package:equatable/equatable.dart';

class SavedAddressEntity extends Equatable {
  final String id;
  final String name;
  final String details;
  final String phone;
  final String city;

  const SavedAddressEntity({
    required this.id,
    required this.name,
    required this.details,
    required this.phone,
    required this.city,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    details,
    phone,
    city,
  ];
}