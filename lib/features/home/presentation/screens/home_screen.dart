import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/home/presentation/widgets/banner_cursor.dart';
import 'package:ecommerce/features/home/presentation/widgets/category_item.dart';
import 'package:ecommerce/shared/custom_error.dart';
import 'package:ecommerce/shared/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../providers/home_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch both providers simultaneously
    final categoriesAsync = ref.watch(homeCategoriesProvider);
    final brandsAsync = ref.watch(homeBrandsProvider);

    return Scaffold(
      backgroundColor: AppColors.grey100,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/logo.svg",
                height: 40,
                width: 30,
                color: AppColors.primary,
              ),
              const SizedBox(height: 24),
              const BannerCursor(),
              const SizedBox(height: 24),

              // --- Categories Section ---
              const Text(
                'Popular Categories',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              categoriesAsync.when(
                data: (categories) {
                  if (categories.isEmpty) {
                    return const Center(child: Text('No categories found.'));
                  }

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final category = categories[index];
                      return CategoryItem(
                        imageUrl: category.image,
                        name: category.name,
                      );
                    },
                  );
                },
                loading: () => const CustomLoading(),
                error: (error, stackTrace) => CustomError(
                  errorMessage: error.toString(),
                  onRetry: () {
                    ref.invalidate(homeCategoriesProvider);
                  },
                ),
              ),

              const SizedBox(height: 32),

              // --- Brands Section ---
              const Text(
                'Popular Brands',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              brandsAsync.when(
                data: (brands) {
                  if (brands.isEmpty) {
                    return const Center(child: Text('No brands found.'));
                  }

                  // Uses the exact same GridView architecture as the Categories above
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 0.75,
                        ),
                    itemCount: brands.length,
                    itemBuilder: (context, index) {
                      final brand = brands[index];

                      // Using your CategoryItem structure as a template layout for the brand items
                      return CategoryItem(
                        imageUrl: brand.image,
                        name: brand.name,
                      );
                    },
                  );
                },
                loading: () => const CustomLoading(),
                error: (error, stackTrace) => CustomError(
                  errorMessage: error.toString(),
                  onRetry: () {
                    ref.invalidate(homeBrandsProvider);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
