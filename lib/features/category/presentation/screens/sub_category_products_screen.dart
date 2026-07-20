import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/category/presentation/providers/category_providers.dart';
import 'package:ecommerce/features/category/presentation/screens/product_details_screen.dart';
import 'package:ecommerce/features/category/presentation/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    final productsAsync = ref.watch(
      productsBySubCategoryProvider(subCategoryId),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
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
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ProductDetailsScreen(product: product)));
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
