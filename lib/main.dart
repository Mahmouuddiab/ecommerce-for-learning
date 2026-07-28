import 'package:ecommerce/core/network/api_constant.dart';
import 'package:ecommerce/core/network/dio_helper.dart';
import 'package:ecommerce/core/router/app_router.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init(
    baseUrl: ApiConstants.baseUrl,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'E-Commerce',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
              onPrimary: AppColors.textPrimary,
            ),
            appBarTheme: AppBarThemeData(
              iconTheme: IconThemeData(
                color: AppColors.primary
              )
            ),
            useMaterial3: true,
          ),
          routerConfig: ref.watch(routerProvider),
        );
      },
    );
  }
}