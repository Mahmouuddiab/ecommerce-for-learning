import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/home/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySidebar extends StatelessWidget {
  final List<CategoryEntity> categories;
  final String selectedId;
  final ValueChanged<String> onCategorySelected;
  final double width;

  const CategorySidebar({
    super.key,
    required this.categories,
    required this.selectedId,
    required this.onCategorySelected,
    this.width = 110,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      color: AppColors.cccc,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.id == selectedId;
          return _CategoryTile(
            label: category.name,
            isSelected: isSelected,
            onTap: () => onCategorySelected(category.id),
          );
        },
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.white : AppColors.cccc,
          border: Border(
            left: BorderSide(
              color: isSelected ? AppColors.primary : Colors.transparent,
              width: 3.w,
            ),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? AppColors.primary : AppColors.primary,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}