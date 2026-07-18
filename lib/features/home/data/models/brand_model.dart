import 'package:ecommerce/features/home/domain/entities/brand_entity.dart';

class BrandModel extends BrandEntity {
  const BrandModel({
    required super.id,
    required super.name,
    required super.slug,
    required super.image,
  });

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      image: json['image'] as String? ?? '',
    );
  }

}