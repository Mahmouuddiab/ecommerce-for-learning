import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/cart/presentation/providers/cart_providers.dart';
import 'package:ecommerce/features/category/presentation/providers/category_providers.dart';
import 'package:ecommerce/features/category/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SubCategoryProductsScreen extends ConsumerWidget {
  final String subCategoryId;
  final String subCategoryName;

  const SubCategoryProductsScreen({
    super.key,
    required this.subCategoryId,
    required this.subCategoryName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Listen for Add To Cart success/error feedback (Check if mounted to avoid errors on pop)
    ref.listen<AddToCartState>(cartControllerProvider, (previous, next) {
      if (!context.mounted) return;

      if (next is AddToCartSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Added to cart successfully! (${next.cartResponse.numOfCartItems} items)',
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
      } else if (next is AddToCartError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    });

    final productsAsync = ref.watch(
      productsBySubCategoryProvider(subCategoryId),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 22.sp),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/home'); // Fallback route if stack is empty
            }
          },
        ),
        title: Text(
          subCategoryName,
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: productsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Failed to load products: $error'),
              SizedBox(height: 12.h),
              ElevatedButton(
                onPressed: () => ref.invalidate(
                  productsBySubCategoryProvider(subCategoryId),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (products) {
          if (products.isEmpty) {
            return const Center(
              child: Text('No products available for this subcategory.'),
            );
          }

          return RefreshIndicator(
            color: AppColors.primary,
            onRefresh: () async {
              ref.invalidate(productsBySubCategoryProvider(subCategoryId));
              await ref.read(
                productsBySubCategoryProvider(subCategoryId).future,
              );
            },
            child: GridView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
              ),
              itemBuilder: (context, index) {
                final product = products[index];
                return ProductItem(
                  product: product,
                  onTap: () {
                    context.push('/product-details', extra: product);
                  },
                  onAddToCartTap: () {
                    ref
                        .read(cartControllerProvider.notifier)
                        .addToCart(product.id);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}