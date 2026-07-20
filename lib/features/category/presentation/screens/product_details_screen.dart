import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/category/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentImageIndex = 0;
  int _quantity = 1;
  bool _isExpanded = false;
  int _selectedSizeIndex = 2; // Default to '40'
  int _selectedColorIndex = 1; // Default to red

  // Mock sizes & colors for clothing/shoes UI
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
    final num effectivePrice =
        widget.product.priceAfterDiscount ?? widget.product.price;
    final List<String> imageList = widget.product.images.isNotEmpty
        ? widget.product.images
        : [widget.product.imageCover];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color(0xFF004182), size: 22.sp),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Product Details',
          style: TextStyle(
            color: const Color(0xFF004182),
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: const Color(0xFF004182), size: 27.sp),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart_outlined,
                color: const Color(0xFF004182), size: 27.sp),
            onPressed: () {},
          ),
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
                  // 1. Image Carousel & Page Indicators
                  _buildImageCarousel(imageList),
                  SizedBox(height: 16.h),

                  // 2. Title & Price Row
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
                        'EGP ${effectivePrice.toStringAsFixed(0)}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF004182),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  // 3. Stats & Quantity Counter
                  Row(
                    children: [
                      // Sold Count Pill
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: const Color(0xFF004182).withOpacity(0.3),
                          ),
                        ),
                        child: Text(
                          '${widget.product.sold} Sold',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF004182),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),

                      // Rating Average & Quantity
                      Icon(Icons.star, size: 16.sp, color: const Color(0xFFFDD835)),
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

                      // Quantity Selector
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
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
                              child: Icon(Icons.remove_circle_outline,
                                  color: Colors.white, size: 20.sp),
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
                              child: Icon(Icons.add_circle_outline,
                                  color: Colors.white, size: 20.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  // 4. Description Section
                  Text(
                    'Description',
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
                              _isExpanded ? 'Read Less' : 'Read More',
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

                  // 5. Size Selector
                  Text(
                    'Size',
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
                        onTap: () =>
                            setState(() => _selectedSizeIndex = index),
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

                  // 6. Color Selector
                  Text(
                    'Color',
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
                              ? Icon(Icons.check,
                              color: Colors.white, size: 18.sp)
                              : null,
                        ),
                      );
                    }),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),

          // 7. Bottom Navigation Bar with Total Price & Add to Cart CTA
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total price',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF004182).withOpacity(0.6),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'EGP ${(effectivePrice * _quantity).toStringAsFixed(0)}',
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
                    onPressed: () {
                      // TODO: Add to cart action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF004182),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add_shopping_cart,
                            color: Colors.white, size: 20.sp),
                        SizedBox(width: 8.w),
                        Text(
                          'Add to cart',
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

  // Helper Widget for Header Carousel
  Widget _buildImageCarousel(List<String> imageList) {
    return Container(
      height: 240.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: const Color(0xFF004182).withOpacity(0.3),
        ),
      ),
      child: Stack(
        children: [
          // Image ViewPager
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

          // Floating Favorite Heart Icon
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
}