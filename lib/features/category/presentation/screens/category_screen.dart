import 'package:collection/collection.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/category/presentation/providers/category_providers.dart';
import 'package:ecommerce/features/category/presentation/screens/sub_category_products_screen.dart';
import 'package:ecommerce/features/category/presentation/widgets/category_sidebar.dart';
import 'package:ecommerce/features/category/presentation/widgets/promo_banner.dart';
import 'package:ecommerce/features/category/presentation/widgets/sub_category_grid.dart';
import 'package:ecommerce/features/home/presentation/providers/home_providers.dart';
import 'package:ecommerce/shared/app_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// State Provider to hold the currently selected active category ID
final selectedCategoryIdProvider = StateProvider<String?>((ref) => null);

class CategoryScreen extends ConsumerWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(homeCategoriesProvider);
    final selectedId = ref.watch(selectedCategoryIdProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.w),
          child: Column(
            children: [
              AppHeader(
                cartItemCount: 0,
                onCartTap: () {
                  // TODO: Navigate to cart
                },
                onSearchChanged: (query) {
                  // TODO: Implement search behavior
                },
              ),
              SizedBox(height: 7.h),
              Expanded(
                child: categoriesAsync.when(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  error: (error, _) => _ErrorState(
                    message: error.toString(),
                    onRetry: () => ref.invalidate(homeCategoriesProvider),
                  ),
                  data: (categories) {
                    if (categories.isEmpty) {
                      return const Center(child: Text('No categories found.'));
                    }

                    // Default to first category if none selected
                    final activeId = selectedId ?? categories.first.id;

                    // Find active category entity to read its name
                    final activeCategory = categories.firstWhereOrNull(
                          (c) => c.id == activeId,
                    ) ??
                        categories.first;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left Pane: Category Selection Sidebar
                        CategorySidebar(
                          categories: categories,
                          selectedId: activeId,
                          onCategorySelected: (id) {
                            ref.read(selectedCategoryIdProvider.notifier).state = id;
                          },
                        ),
                        // Right Pane: Dynamic Subcategories & Banner
                        Expanded(
                          child: AnimatedSwitcher(
                            duration: const Duration(milliseconds: 220),
                            switchInCurve: Curves.easeOut,
                            switchOutCurve: Curves.easeIn,
                            transitionBuilder: (child, animation) => FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                            child: _CategoryContentSection(
                              key: ValueKey(activeId),
                              categoryId: activeId,
                              categoryName: activeCategory.name,
                            ),
                          ),
                        ),
                      ],
                    );
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

/// Right-hand pane displaying selected category name, promo banner, and subcategories
class _CategoryContentSection extends ConsumerWidget {
  final String categoryId;
  final String categoryName;

  const _CategoryContentSection({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Fetch sub-categories dynamically using your family provider
    final subCategoriesAsync = ref.watch(subCategoriesProvider(categoryId));

    return subCategoriesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _ErrorState(
        message: error.toString(),
        onRetry: () => ref.invalidate(subCategoriesProvider(categoryId)),
      ),
      data: (subCategories) {
        return RefreshIndicator(
          color: AppColors.primary,
          onRefresh: () async {
            ref.invalidate(subCategoriesProvider(categoryId));
            await ref.read(subCategoriesProvider(categoryId).future);
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Selected Category Title Header
                Padding(
                  padding: EdgeInsets.only(left: 12.w, top: 8.h, bottom: 8.h),
                  child: Text(
                    categoryName,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                ),

                // 2. Promo Banner
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: PromoBanner(
                    title: 'Up to 50% Off',
                    imageUrl: '', // Optional: pass default banner URL or entity image
                    ctaLabel: 'Shop Now',
                    onShopNowTap: () {
                      // TODO: Navigate to full category listing
                    },
                  ),
                ),
                SizedBox(height: 8.h),

                // 3. Subcategories Grid or Empty State
                if (subCategories.isEmpty)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 48.h),
                    child: Center(
                      child: Column(
                        children: [
                          Icon(
                            Icons.category_outlined,
                            size: 36.sp,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'No sub-categories available.',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SubCategoryGrid(
                    items: subCategories,
                    onItemTap: (item) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubCategoryProductsScreen(
                            subCategoryId: item.id,
                            subCategoryName: item.name,
                          ),
                        ),
                      );
                    },
                  ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

/// Reusable Error State Widget with Retry Action
class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.textSecondary,
              size: 32.sp,
            ),
            SizedBox(height: 8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 12.h),
            OutlinedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}