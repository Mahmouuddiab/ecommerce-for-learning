import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppHeader extends StatelessWidget {
  final String hintText;
  final int cartItemCount;
  final ValueChanged<String>? onSearchChanged;
  final VoidCallback? onSearchTap;
  final VoidCallback? onCartTap;
  final TextEditingController? searchController;

  const AppHeader({
    super.key,
    this.hintText = 'what do you search for?',
    this.cartItemCount = 0,
    this.onSearchChanged,
    this.onSearchTap,
    this.onCartTap,
    this.searchController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Row 1: Logo
          SvgPicture.asset(
            'assets/logo.svg',
            height: 30.h,
            color: AppColors.primary,
          ),
          SizedBox(height: 15.h),
          // Row 2: Search field + Cart icon
          Row(
            children: [
              Expanded(
                child: _SearchField(
                  hintText: hintText,
                  controller: searchController,
                  onChanged: onSearchChanged,
                  onTap: onSearchTap,
                ),
              ),
              SizedBox(width: 20.w),
              _CartIcon(itemCount: cartItemCount, onTap: onCartTap),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;

  const _SearchField({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(
          color: AppColors.primary,
          width: 1.w,
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        style: TextStyle(
          fontSize: 14.sp,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 13.sp,
            color: AppColors.primary.withOpacity(0.6),
            fontWeight: FontWeight.w300,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Icon(
              Icons.search,
              size: 24.sp,
              color: AppColors.primary,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 40.w,
            minHeight: 24.h,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
      ),
    );
  }
}

class _CartIcon extends StatelessWidget {
  final int itemCount;
  final VoidCallback? onTap;

  const _CartIcon({required this.itemCount, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 26.sp,
              color: AppColors.primary,
            ),
            if (itemCount > 0)
              Positioned(
                right: -4,
                top: -4,
                child: Container(
                  padding: EdgeInsets.all(2.w),
                  constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.w),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '$itemCount',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 9.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}