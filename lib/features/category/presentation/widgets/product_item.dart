import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/category/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductItem extends StatefulWidget {
  final ProductEntity product;
  final bool isFavorite; // Added flag
  final VoidCallback? onFavoriteTap;
  final VoidCallback? onAddToCartTap;
  final VoidCallback onTap;

  const ProductItem({
    super.key,
    required this.product,
    this.isFavorite = false, // Default to false
    this.onFavoriteTap,
    this.onAddToCartTap,
    required this.onTap,
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final effectivePrice = widget.product.priceAfterDiscount ?? widget.product.price;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.3),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Image with Favorite Button
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(13.r),
                    ),
                    child: Image.network(
                      widget.product.imageCover,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Center(
                        child: Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
                  // Favorite Heart Button
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: InkWell(
                      onTap: widget.onFavoriteTap,
                      borderRadius: BorderRadius.circular(20.r),
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
                          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 18.sp,
                          color: widget.isFavorite ? Colors.red : AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 2. Details Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    widget.product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF004182),
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 6.h),

                  // Price and Strikethrough Price
                  Row(
                    children: [
                      Text(
                        'EGP $effectivePrice',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF004182),
                        ),
                      ),
                      if (widget.product.priceAfterDiscount != null) ...[
                        SizedBox(width: 8.w),
                        Text(
                          '${widget.product.price} EGP',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF004182).withOpacity(0.6),
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),

                  // Reviews & Add Button Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Rating / Review Count
                      Row(
                        children: [
                          Text(
                            'Review (${widget.product.ratingsAverage})',
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF004182),
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.star,
                            size: 14.sp,
                            color: const Color(0xFFFDD835),
                          ),
                        ],
                      ),

                      // Add to Cart Button (+)
                      InkWell(
                        onTap: widget.onAddToCartTap,
                        borderRadius: BorderRadius.circular(15.r),
                        child: Container(
                          padding: EdgeInsets.all(4.r),
                          decoration: const BoxDecoration(
                            color: Color(0xFF004182),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}