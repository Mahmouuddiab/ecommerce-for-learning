class SubCategoryEntity {
  final String id;
  final String name;
  final String slug;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SubCategoryEntity({
    required this.id,
    required this.name,
    required this.slug,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
  });
}