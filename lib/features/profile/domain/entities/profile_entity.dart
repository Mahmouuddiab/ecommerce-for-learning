import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String id;
  final String role;
  final bool active;
  final List<dynamic> wishlist;
  final String name;
  final String email;
  final String phone;
  final List<dynamic> addresses;
  final DateTime createdAt;
  final DateTime updatedAt;

  const ProfileEntity({
    required this.id,
    required this.role,
    required this.active,
    required this.wishlist,
    required this.name,
    required this.email,
    required this.phone,
    required this.addresses,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    role,
    active,
    wishlist,
    name,
    email,
    phone,
    addresses,
    createdAt,
    updatedAt,
  ];
}
