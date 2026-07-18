import 'package:ecommerce/core/cache/cache_helper.dart';
import 'package:ecommerce/core/screens/main_navigation_screen.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    // 1. Initialize the 2-second animation timeline
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // 2. Scale up smoothly with an elastic finish
    _scaleAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    // 3. Fade in smoothly
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    // 4. Start the animation sequence
    _animationController.forward();

    // 5. Updated: Call the separate navigation logic method once complete
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToNextScreen();
      }
    });
  } // <-- initState ends cleanly here

  // Moved: This is now a proper class-level method
  Future<void> _navigateToNextScreen() async {
    // 1. Fetch the actual authentication state from secure storage
    bool userLoggedIn = await CacheHelper.isLoggedIn();

    // 2. Safely check if the screen is still active before navigating
    if (!mounted) return;

    // 3. Route the user based on token availability
    if (userLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose(); // Avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return Opacity(
              opacity: _opacityAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: child,
              ),
            );
          },
          child: SvgPicture.asset(
            'assets/logo.svg',
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}