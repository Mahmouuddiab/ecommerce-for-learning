import 'package:ecommerce/core/params/register_params.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/core/validator/app_validator.dart';
import 'package:ecommerce/features/auth/presentation/providers/auth_providers.dart';
import 'package:ecommerce/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce/features/auth/presentation/widegts/auth_text_field.dart';
import 'package:ecommerce/features/auth/presentation/widegts/option_row.dart';
import 'package:ecommerce/shared/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final params = RegisterParams(
      name: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      rePassword: _confirmPasswordController.text,
    );

    ref.read(authControllerProvider.notifier).signUp(params);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(authControllerProvider, (previous, next) {
      next.when(
        data: (user) {
          if (user != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account created successfully 🎉'),
                backgroundColor: Colors.green,
              ),
            );
            // TODO: Navigate to Home or Login Screen
          }
        },
        loading: () {},
        error: (error, stackTrace) {
          // This will grab "Account Already Exists" directly from the exception text
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
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  SvgPicture.asset("assets/logo.svg"),
                  SizedBox(height: 40.h),
                  AuthTextField(
                    label: "Full Name",
                    hint: "enter your full name ",
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                    validator: (v) => AppValidator.name(v ?? ''),
                  ),
                  SizedBox(height: 16.h),
                  AuthTextField(
                    label: "Mobile Number",
                    hint: "enter your mobile no",
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (v) => AppValidator.egyptPhone(v ?? ''),
                  ),
                  SizedBox(height: 16.h),
                  AuthTextField(
                    label: "E-mail Address",
                    hint: "enter your email address",
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (v) => AppValidator.email(v ?? ''),
                  ),
                  SizedBox(height: 16.h),
                  AuthTextField(
                    label: "Password",
                    hint: "enter your password",
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    validator: (v) => AppValidator.password(v ?? ''),
                    isPassword: true,
                  ),
                  SizedBox(height: 16.h),
                  AuthTextField(
                    label: "Confirm Password",
                    hint: "enter your password confirmation",
                    controller: _confirmPasswordController,
                    keyboardType: TextInputType.text,
                    validator: (v) => AppValidator.confirmPassword(
                      v ?? '',
                      _passwordController.text,
                    ),
                    isPassword: true,
                  ),
                  SizedBox(height: 32.h),
                  PrimaryButton(
                    label: "Sign Up",
                    isLoading: isLoading,
                    onPressed: isLoading ? null : _submit,
                  ),
                  SizedBox(height: 20.h),
                  OptionRow(
                    questionText: "Already have an account? ",
                    actionText: "Login",
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
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