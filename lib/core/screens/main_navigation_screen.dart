import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/category/presentation/screens/category_screen.dart';
import 'package:ecommerce/features/home/presentation/screens/home_screen.dart';
import 'package:ecommerce/features/profile/presentation/screens/profile_screen.dart';
import 'package:ecommerce/features/wishlist/presentation/screens/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Static list tracking our self-contained layout elements
  static const List<Widget> _appScreens = <Widget>[
    HomeScreen(),      // Index 0
    CategoryScreen(),  // Index 1
    WishlistScreen(),  // Index 2
    ProfileScreen(),   // Index 3
  ];

  static const List<_NavItemData> _navItems = <_NavItemData>[
    _NavItemData(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    _NavItemData(
      icon: Icons.grid_view,
      activeIcon: Icons.grid_view_rounded,
      label: 'Categories',
    ),
    _NavItemData(
      icon: Icons.favorite_outline,
      activeIcon: Icons.favorite,
      label: 'Wishlist',
    ),
    _NavItemData(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
    ),
  ];

  void _onTabChanged(int selectedIndex) {
    if (selectedIndex == _currentIndex) return;
    setState(() {
      _currentIndex = selectedIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // IndexedStack preserves the scrolling performance and internal state of each subscreen
      body: IndexedStack(
        index: _currentIndex,
        children: _appScreens,
      ),
      bottomNavigationBar: _CustomBottomNavBar(
        currentIndex: _currentIndex,
        items: _navItems,
        onTap: _onTabChanged,
      ),
    );
  }
}

class _NavItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _NavItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class _CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<_NavItemData> items;
  final ValueChanged<int> onTap;

  const _CustomBottomNavBar({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 12.r,
            offset: Offset(0, -4.h),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(items.length, (index) {
              final bool isActive = index == currentIndex;
              final item = items[index];
              return _NavBarButton(
                icon: isActive ? item.activeIcon : item.icon,
                label: item.label,
                isActive: isActive,
                onTap: () => onTap(index),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavBarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarButton({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primaryLight.withOpacity(0.25)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: isActive ? AppColors.textPrimary : AppColors.textMuted,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 11.sp,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? AppColors.textPrimary : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}