import 'package:ecommerce/features/wishlist/domain/entities/wishlist_response_entity.dart';

abstract class WishlistState {}

class WishlistInitial extends WishlistState {}

class WishlistLoading extends WishlistState {}

class WishlistSuccess extends WishlistState {
  final WishlistResponseEntity wishlistResponse;
  final String message;

  WishlistSuccess(this.wishlistResponse, {this.message = ''});
}

class WishlistError extends WishlistState {
  final String message;
  WishlistError(this.message);
}