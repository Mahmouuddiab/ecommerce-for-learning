import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/localization/translation_keys.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/cart/presentation/providers/cart_providers.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_item.dart';
import 'package:ecommerce/features/cart/presentation/widgets/checkout_bottom_bar.dart';
import 'package:ecommerce/features/order/presentation/screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  Future<void> _showDeleteConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
    String productId,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(TranslationKeys.cart.deleteItem.tr()),
          content: Text(TranslationKeys.cart.deleteConfirmMessage.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(
                TranslationKeys.cart.cancel.tr(),
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                ref
                    .read(cartControllerProvider.notifier)
                    .deleteFromCart(productId);
              },
              child: Text(TranslationKeys.cart.delete.tr()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AddToCartState>(cartControllerProvider, (previous, next) {
      if (next is AddToCartSuccess) {
        ref.invalidate(cartProductsProvider);
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(TranslationKeys.cart.productRemovedSuccess.tr()),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
      } else if (next is AddToCartError) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(next.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 3),
            ),
          );
      }
    });

    final cartAsync = ref.watch(cartProductsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          TranslationKeys.cart.title.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: AppColors.primary),
            onPressed: () => ref.invalidate(cartProductsProvider),
          ),
        ],
      ),
      body: cartAsync.when(
        data: (cartResponse) {
          final cartItems = cartResponse.products;
          final String cartId = cartResponse.cartId;
          final double totalAmount = cartResponse.totalCartPrice.toDouble();

          if (cartItems.isEmpty) {
            return const _EmptyCartView();
          }

          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(cartProductsProvider);
              await ref.read(cartProductsProvider.future);
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartItems.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return CartItem(
                        item: item,
                        onDelete: () {
                          _showDeleteConfirmationDialog(context, ref, item.id);
                        },
                      );
                    },
                  ),
                ),
                CheckoutBottomBar(
                  totalAmount: totalAmount,
                  onCheckout: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CheckoutScreen(cartId: cartId),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 12),
                Text(
                  TranslationKeys.cart.failedToLoad.tr(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.invalidate(cartProductsProvider),
                  child: Text(TranslationKeys.cart.tryAgain.tr()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyCartView extends StatelessWidget {
  const _EmptyCartView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            TranslationKeys.cart.emptyCartTitle.tr(),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            TranslationKeys.cart.emptyCartSubtitle.tr(),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
