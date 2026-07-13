import 'package:ecommerce/core/params/login_params.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/validator/app_validator.dart';
import 'package:ecommerce/features/auth/presentation/providers/auth_providers.dart';
import 'package:ecommerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ecommerce/features/auth/presentation/widegts/auth_text_field.dart';
import 'package:ecommerce/features/auth/presentation/widegts/option_row.dart';
import 'package:ecommerce/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final params = LoginParams(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    ref.read(authControllerProvider.notifier).signIn(params);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(authControllerProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Welcome back! 🎉'),
                backgroundColor: Colors.green,
              ),
            );
            // TODO: Navigate to Home Screen
          }
        },
        loading: () {},
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString().replaceFirst('Exception: ', '')),
              backgroundColor: Colors.redAccent,
            ),
          );
        },
      );
    });

    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  // App Logo centered
                  Center(
                    child: SvgPicture.asset(
                      "assets/logo.svg",
                      width: 200.w,
                    ),
                  ),
                  SizedBox(height: 70.h),

                  // Welcome Headers
                  Text(
                    "Welcome Back To Route",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    "Please sign in with your mail",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 32.h),

                  // Email/User Name Field
                  AuthTextField(
                    label: "User Name",
                    hint: "enter your name",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => AppValidator.email(v ?? ''),
                  ),
                  SizedBox(height: 20.h),

                  // Password Field
                  AuthTextField(
                    label: "Password",
                    hint: "enter your password",
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    validator: (v) => AppValidator.password(v ?? ''),
                    isPassword: true,
                  ),
                  SizedBox(height: 8.h),

                  // Forgot Password Button aligned right
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        // TODO: Implement forgot password action
                      },
                      child: Text(
                        "Forgot password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 50.h),

                  // Login Action Button
                  PrimaryButton(
                    label: "Login",
                    isLoading: isLoading,
                    onPressed: isLoading ? null : _submit,
                  ),
                  SizedBox(height: 24.h),

                  // Switch Auth Flow Link centered
                  Center(
                    child: OptionRow(
                      questionText: "Don't have an account? ",
                      actionText: "Create Account",
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpScreen()),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}