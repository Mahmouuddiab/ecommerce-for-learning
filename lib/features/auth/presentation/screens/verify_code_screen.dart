import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/auth/domain/entities/verify_code_entity.dart';
import 'package:ecommerce/features/auth/presentation/providers/auth_providers.dart';
import 'package:ecommerce/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:ecommerce/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCodeScreen extends ConsumerStatefulWidget {
  final String email;

  const VerifyCodeScreen({super.key, required this.email});

  @override
  ConsumerState<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends ConsumerState<VerifyCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  void _verify() {
    if (!_formKey.currentState!.validate()) return;

    final code = _codeController.text.trim();
    ref.read(authControllerProvider.notifier).verifyCode(code);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState is AsyncLoading;

    // Listen to state changes to handle success and error side-effects
    ref.listen<AsyncValue<Object?>>(authControllerProvider, (previous, next) {
      next.whenOrNull(
        data: (data) {
          if (data is VerifyCodeEntity) {
            // Reset the state to prevent duplicate triggers upon returning
            ref.read(authControllerProvider.notifier).reset();

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Code verified successfully!"),
                backgroundColor: Colors.green,
              ),
            );

            Future.delayed(const Duration(milliseconds: 500), () {
              if (context.mounted) {
                context.goNamed(
                  'reset-password',
                  extra: widget.email,
                );
              }
            });
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
                  child: SvgPicture.asset("assets/logo.svg", width: 200.w),
                ),

                SizedBox(height: 60.h),

                Text(
                  "Verify Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  "Enter the 6-digit code sent to\n${widget.email}",
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                ),

                SizedBox(height: 50.h),

                PinCodeTextField(
                  appContext: context,
                  controller: _codeController,
                  length: 6,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  enableActiveFill: true,
                  autoFocus: true,
                  cursorColor: AppColors.primary,
                  autoDisposeControllers: false,
                  errorTextSpace: 25.h,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return "Enter the complete 6-digit code";
                    }
                    return null;
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12.r),
                    fieldHeight: 55.h,
                    fieldWidth: 48.w,

                    // Outer border styling
                    activeColor: Colors.white,
                    inactiveColor: Colors.white54,
                    selectedColor: Colors.white,

                    // Background fill styling
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white.withOpacity(0.9),
                    selectedFillColor: Colors.white,

                    // Error boundary styling
                    errorBorderColor: Colors.redAccent,

                    borderWidth: 1.5,
                  ),
                  textStyle: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  onChanged: (_) {},
                  onCompleted: (value) {
                    if (!isLoading) {
                      _verify(); // Trigger validation automatically when the last digit is filled
                    }
                  },
                ),

                SizedBox(height: 10.h),

                Center(
                  child: TextButton(
                    onPressed: isLoading
                        ? null
                        : () {
                            // Resend verification code by invoking forgotPassword with user's email
                            ref
                                .read(authControllerProvider.notifier)
                                .forgotPassword(widget.email);
                          },
                    child: Text(
                      "Resend Code",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 40.h),

                PrimaryButton(
                  label: "Verify",
                  isLoading: isLoading,
                  onPressed: isLoading ? null : _verify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
