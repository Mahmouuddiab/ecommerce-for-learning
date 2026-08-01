import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/localization/translation_keys.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/validator/app_validator.dart';
import 'package:ecommerce/features/auth/domain/entities/forgot_password.dart';
import 'package:ecommerce/features/auth/presentation/providers/auth_providers.dart';
import 'package:ecommerce/features/auth/presentation/widegts/auth_text_field.dart';
import 'package:ecommerce/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    ref
        .read(authControllerProvider.notifier)
        .forgotPassword(_emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<Object?>>(authControllerProvider, (previous, next) {
      next.when(
        data: (data) {
          if (data is ForgotPasswordEntity) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(data.message),
                backgroundColor: Colors.green,
              ),
            );

            Future.delayed(const Duration(milliseconds: 500), () {
              if (context.mounted) {
                context.goNamed(
                  'verify-code',
                  extra: _emailController.text.trim(),
                );
              }
            });
          }
        },
        loading: () {},
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString().replaceFirst('Exception: ', '')),
              backgroundColor: Colors.red,
            ),
          );
        },
      );
    });

    final state = ref.watch(authControllerProvider);
    final isLoading = state.isLoading;

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
                  TranslationKeys.forgotPassword.title.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 8.h),

                Text(
                  TranslationKeys.forgotPassword.subtitle.tr(),
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                ),

                SizedBox(height: 70.h),

                AuthTextField(
                  label: TranslationKeys.forgotPassword.email.tr(),
                  hint: TranslationKeys.forgotPassword.emailHint.tr(),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) => AppValidator.email(v ?? ''),
                ),

                SizedBox(height: 40.h),

                PrimaryButton(
                  label: TranslationKeys.forgotPassword.sendResetCode.tr(),
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
