import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/localization/translation_keys.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/cart/presentation/providers/cart_providers.dart';
import 'package:ecommerce/features/category/domain/entities/product_entity.dart';
import 'package:ecommerce/features/reviews/presentation/riverpod/review_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final ProductEntity product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  ConsumerState<ProductDetailsScreen> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  int _currentImageIndex = 0;
  int _quantity = 1;
  bool _isExpanded = false;
  int _selectedSizeIndex = 2;
  int _selectedColorIndex = 1;

  final List<int> _sizes = [38, 39, 40, 41, 42, 43];
  final List<Color> _colors = [
    const Color(0xFF2C2C2C),
    const Color(0xFFBC2B1B),
    const Color(0xFF0075E3),
    const Color(0xFF00C853),
    const Color(0xFFFF655B),
  ];

  @override
  Widget build(BuildContext context) {
    ref.listen<AddToCartState>(cartControllerProvider, (previous, next) {
      if (next is AddToCartSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              TranslationKeys.productDetails.addedToCartSuccess.tr(
                namedArgs: {'count': '${next.cartResponse.numOfCartItems}'},
              ),
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

    final num effectivePrice =
        widget.product.priceAfterDiscount ?? widget.product.price;
    final List<String> imageList = widget.product.images.isNotEmpty
        ? widget.product.images
        : [widget.product.imageCover];

    final cartState = ref.watch(cartControllerProvider);
    final isAddingToCart = cartState is AddToCartLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFF004182),
            size: 22.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          TranslationKeys.productDetails.title.tr(),
          style: TextStyle(
            color: const Color(0xFF004182),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: const Color(0xFF004182),
              size: 27.sp,
            ),
            onPressed: () {},
          ),
          Consumer(
            builder: (context, ref, child) {
              final cartCount = ref.watch(cartCountProvider);

              return Badge(
                isLabelVisible: cartCount > 0,
                label: Text(
                  '$cartCount',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: Colors.red,
                offset: const Offset(-4, 4),
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: const Color(0xFF004182),
                    size: 27.sp,
                  ),
                  onPressed: () {
                    context.push('/cart');
                  },
                ),
              );
            },
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageCarousel(imageList),
                  SizedBox(height: 16.h),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.title,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF004182),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '${TranslationKeys.productDetails.currencyEgp.tr()} ${effectivePrice.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF004182),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: const Color(0xFF004182).withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          '${widget.product.sold} ${TranslationKeys.productDetails.sold.tr()}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF004182),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Icon(
                        Icons.star,
                        size: 16.sp,
                        color: const Color(0xFFFDD835),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${widget.product.ratingsAverage} (${widget.product.ratingsQuantity})',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF004182),
                        ),
                      ),
                      const Spacer(),

                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF004182),
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                if (_quantity > 1) {
                                  setState(() => _quantity--);
                                }
                              },
                              child: Icon(
                                Icons.remove_circle_outline,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Text(
                              '$_quantity',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            InkWell(
                              onTap: () {
                                setState(() => _quantity++);
                              },
                              child: Icon(
                                Icons.add_circle_outline,
                                color: Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  Text(
                    TranslationKeys.productDetails.description.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF004182),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.description,
                            maxLines: _isExpanded ? null : 2,
                            overflow: _isExpanded
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF004182).withOpacity(0.7),
                              height: 1.4,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() => _isExpanded = !_isExpanded);
                            },
                            child: Text(
                              _isExpanded
                                  ? TranslationKeys.productDetails.readLess.tr()
                                  : TranslationKeys.productDetails.readMore.tr(),
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF004182),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(height: 16.h),

                  Text(
                    TranslationKeys.productDetails.size.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF004182),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: List.generate(_sizes.length, (index) {
                      final isSelected = index == _selectedSizeIndex;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedSizeIndex = index),
                        child: Container(
                          margin: EdgeInsets.only(right: 12.w),
                          width: 35.r,
                          height: 35.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isSelected
                                ? const Color(0xFF004182)
                                : Colors.transparent,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${_sizes[index]}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF004182),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 16.h),

                  Text(
                    TranslationKeys.productDetails.color.tr(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF004182),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: List.generate(_colors.length, (index) {
                      final isSelected = index == _selectedColorIndex;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedColorIndex = index),
                        child: Container(
                          margin: EdgeInsets.only(right: 12.w),
                          width: 32.r,
                          height: 32.r,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _colors[index],
                          ),
                          child: isSelected
                              ? Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 18.sp,
                          )
                              : null,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 24.h),

                  _buildReviewsSection(ref),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      TranslationKeys.productDetails.totalPrice.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF004182).withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '${TranslationKeys.productDetails.currencyEgp.tr()} ${(effectivePrice * _quantity).toStringAsFixed(0)}',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF004182),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 24.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: isAddingToCart
                        ? null
                        : () {
                      ref
                          .read(cartControllerProvider.notifier)
                          .addToCart(widget.product.id);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004182),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                    child: isAddingToCart
                        ? SizedBox(
                      height: 20.sp,
                      width: 20.sp,
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_shopping_cart,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          TranslationKeys.productDetails.addToCart.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 35.h),
        ],
      ),
    );
  }

  Widget _buildImageCarousel(List<String> imageList) {
    return Container(
      height: 240.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: const Color(0xFF004182).withOpacity(0.3)),
      ),
      child: Stack(
        children: [
          PageView.builder(
            itemCount: imageList.length,
            onPageChanged: (index) {
              setState(() => _currentImageIndex = index);
            },
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(15.r),
                child: Image.network(
                  imageList[index],
                  width: double.infinity,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                ),
              );
            },
          ),

          Positioned(
            top: 12.h,
            right: 12.w,
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.favorite_border,
                size: 20.sp,
                color: const Color(0xFF004182),
              ),
            ),
          ),

          // Page Indicator Dots
          Positioned(
            bottom: 8.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(imageList.length, (index) {
                final isSelected = index == _currentImageIndex;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  height: 6.h,
                  width: isSelected ? 20.w : 6.w,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? const Color(0xFF004182)
                        : Colors.transparent,
                    border: Border.all(color: const Color(0xFF004182)),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection(WidgetRef ref) {
    final reviewsAsync = ref.watch(productReviewsProvider(widget.product.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  TranslationKeys.productDetails.reviews.tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF004182),
                  ),
                ),
                SizedBox(width: 6.w),
                reviewsAsync.maybeWhen(
                  data: (reviews) => Text(
                    '(${reviews.length})',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF004182).withOpacity(0.5),
                    ),
                  ),
                  orElse: () => const SizedBox.shrink(),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.refresh,
                size: 18.sp,
                color: const Color(0xFF004182),
              ),
              onPressed: () {
                ref.invalidate(productReviewsProvider(widget.product.id));
              },
            ),
          ],
        ),
        SizedBox(height: 8.h),

        reviewsAsync.when(
          loading: () => Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: const Center(child: CircularProgressIndicator()),
          ),
          error: (error, stack) => Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.red.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 18.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    TranslationKeys.productDetails.failedToLoadReviews.tr(),
                    style: TextStyle(color: Colors.red, fontSize: 12.sp),
                  ),
                ),
              ],
            ),
          ),
          data: (reviews) {
            if (reviews.isEmpty) {
              return Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 24.h),
                decoration: BoxDecoration(
                  color: const Color(0xFF004182).withOpacity(0.04),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.rate_review_outlined,
                      color: const Color(0xFF004182).withOpacity(0.3),
                      size: 28.sp,
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      TranslationKeys.productDetails.noReviewsYet.tr(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF004182).withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              );
            }

            return SizedBox(
              height: 140.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: reviews.length,
                separatorBuilder: (context, index) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return _buildReviewCard(review);
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildReviewCard(dynamic review) {
    final initial = review.userName.isNotEmpty
        ? review.userName[0].toUpperCase()
        : '?';

    return Container(
      width: 240.w,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFF004182).withOpacity(0.08)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF004182).withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16.r,
                backgroundColor: const Color(0xFF004182).withOpacity(0.1),
                child: Text(
                  initial,
                  style: TextStyle(
                    color: const Color(0xFF004182),
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  review.userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF004182),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: List.generate(5, (i) {
              final filled = i < review.rating.round();
              return Icon(
                filled ? Icons.star : Icons.star_border,
                size: 14.sp,
                color: const Color(0xFFFDD835),
              );
            }),
          ),
          SizedBox(height: 6.h),
          Expanded(
            child: Text(
              review.review,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12.sp,
                color: const Color(0xFF004182).withOpacity(0.75),
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}