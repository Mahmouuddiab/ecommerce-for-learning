import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/category/domain/entities/sub_category_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SubCategoryGrid extends StatelessWidget {
  final List<SubCategoryEntity> items;
  final ValueChanged<SubCategoryEntity>? onItemTap;
  final int crossAxisCount;

  const SubCategoryGrid({
    super.key,
    required this.items,
    this.onItemTap,
    this.crossAxisCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 10.h,
        crossAxisSpacing: 10.w,
        mainAxisExtent: 140.h,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return _SubCategoryTile(
          item: item,
          onTap: onItemTap == null ? null : () => onItemTap!(item),
        );
      },
    );
  }
}

class _SubCategoryTile extends StatelessWidget {
  final SubCategoryEntity item;
  final VoidCallback? onTap;

  const _SubCategoryTile({required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: Colors.grey.shade300),
        ),
        padding: EdgeInsets.all(8.w),
        child: Column(
          children: [
            // Flexible wrapper prevents avatar from forcing Column out of bounds
            Expanded(
              child: Center(
                child: CircleAvatar(
                  radius: 26.r,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    item.name.isNotEmpty ? item.name[0].toUpperCase() : '?',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              item.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
