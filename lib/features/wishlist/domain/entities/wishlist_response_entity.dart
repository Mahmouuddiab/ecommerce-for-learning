class WishlistResponseEntity {
  final String status;
  final String message;
  final List<String> data;

  const WishlistResponseEntity({
    required this.status,
    required this.message,
    required this.data,
  });
}