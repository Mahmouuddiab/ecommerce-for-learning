import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/cart/presentation/providers/cart_providers.dart';
import 'package:ecommerce/features/cart/presentation/widgets/cart_item.dart';
import 'package:ecommerce/features/cart/presentation/widgets/checkout_bottom_bar.dart';
import 'package:ecommerce/features/order/presentation/screen/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  /// Helper method to show confirmation dialog
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
          title: const Text('Delete Item'),
          content: const Text(
            'Are you sure you want to remove this item from your cart?',
          ),
          actions: [
            // Option 1: Cancel
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            // Option 2: Confirm Delete
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close dialog
                ref
                    .read(cartControllerProvider.notifier)
                    .deleteFromCart(productId); // Trigger delete
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen for controller actions (add/delete feedback)
    ref.listen<AddToCartState>(cartControllerProvider, (previous, next) {
      if (next is AddToCartSuccess) {
        // Refresh the cart list on success
        ref.invalidate(cartProductsProvider);

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(
              content: Text('Product removed successfully'),
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
        title: const Text(
          'Cart',
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
                  'Failed to load cart items',
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
                  child: const Text('Try Again'),
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
          const Text(
            'Your cart is empty',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Explore items and add them to your cart!',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}