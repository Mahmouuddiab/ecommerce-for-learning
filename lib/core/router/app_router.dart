import 'package:ecommerce/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:ecommerce/features/order/presentation/screen/checkout_screen.dart';
import 'package:ecommerce/features/profile/presentation/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/core/router/app_routes.dart';
import 'package:ecommerce/core/screens/splash_screen.dart';
import 'package:ecommerce/features/adresses/presentation/screens/add_address_screen.dart';
import 'package:ecommerce/features/adresses/presentation/screens/saved_address_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce/features/auth/presentation/screens/verify_code_screen.dart';
import 'package:ecommerce/features/cart/presentation/screens/cart_screen.dart';
import 'package:ecommerce/features/category/domain/entities/product_entity.dart';
import 'package:ecommerce/features/category/presentation/screens/product_details_screen.dart';
import 'package:ecommerce/features/category/presentation/screens/sub_category_products_screen.dart';
import 'package:ecommerce/features/profile/presentation/screens/privacy_policy_screen.dart';
import 'package:ecommerce/features/wishlist/presentation/screens/wishlist_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case AppRoutes.signUp:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
        );

      case AppRoutes.forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
        );

      case AppRoutes.verifyCode:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => VerifyCodeScreen(email: email),
        );

      case AppRoutes.resetPassword:
        final email = settings.arguments as String? ?? '';
        return MaterialPageRoute(
          builder: (_) => ResetPasswordScreen(email: email),
        );

      case AppRoutes.cart:
        return MaterialPageRoute(
          builder: (_) => const CartScreen(),
        );

      case AppRoutes.productDetails:
        final product = settings.arguments as ProductEntity;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product),
        );

      case AppRoutes.subCategoryProducts:
        final args = settings.arguments as Map<String, dynamic>? ?? {};
        return MaterialPageRoute(
          builder: (_) => SubCategoryProductsScreen(
            subCategoryId: args['subCategoryId'] as String? ?? '',
            subCategoryName: args['subCategoryName'] as String? ?? '',
          ),
        );

      case AppRoutes.addAddress:
        return MaterialPageRoute(
          builder: (_) => const AddAddressScreen(),
        );

      case AppRoutes.savedAddress:
        return MaterialPageRoute(
          builder: (_) => const SavedAddressScreen(),
        );

      case AppRoutes.privacyPolicy:
        return MaterialPageRoute(
          builder: (_) => const PrivacyPolicyScreen(),
        );

      case AppRoutes.wishlist:
        return MaterialPageRoute(
          builder: (_) => const WishlistScreen(),
        );

      case AppRoutes.setting:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
        );

      case AppRoutes.checkout:
        final cartId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => CheckoutScreen(cartId: cartId),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Route not found'),
            ),
          ),
        );
    }
  }
}