import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/auth/domain/entities/reset_password_entity.dart';
import 'package:ecommerce/features/auth/presentation/providers/auth_providers.dart';
import 'package:ecommerce/shared/custom_text_field.dart';
import 'package:ecommerce/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String email;

  const ResetPasswordScreen({
    super.key,
    required this.email,
  });

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final password = _passwordController.text.trim();
    ref.read(authControllerProvider.notifier).resetPassword(widget.email, password);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState is AsyncLoading;

    // Listen to state changes to handle success and error side-effects
    ref.listen<AsyncValue<Object?>>(authControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data is ResetPasswordEntity) {
            // Reset the state to prevent duplicate triggers
            ref.read(authControllerProvider.notifier).reset();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Password reset successfully! Please login with your new password."),
                backgroundColor: Colors.green,
                duration: Duration(seconds: 3),
              ),
            );

            // Pop back to the initial/login screen
            Navigator.popUntil(context, (route) => route.isFirst);
          }
        },
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Colors.redAccent,
            ),
          );
        },
      );
    });

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),

                Center(
                  child: SvgPicture.asset(
                    "assets/logo.svg",
                    width: 200.w,
                  ),
                ),

                SizedBox(height: 70.h),

                Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  "Create a strong new password for your account associated with\n${widget.email}",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14.sp,
                  ),
                ),

                SizedBox(height: 80.h),

                CustomTextField(
                  controller: _passwordController,
                  hint: "New Password",
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Password cannot be empty";
                    }

                    if (value.trim().length < 6) {
                      return "Password must be at least 6 characters";
                    }

                    return null;
                  },
                ),

                SizedBox(height: 50.h),

                PrimaryButton(
                  label: "Reset Password",
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _submit,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}