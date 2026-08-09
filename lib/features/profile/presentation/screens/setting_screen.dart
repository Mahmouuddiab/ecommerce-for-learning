import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/localization/translation_keys.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/profile/presentation/widgets/language_option_tile.dart';
import 'package:ecommerce/features/profile/presentation/widgets/setting_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isLanguageExpanded = false;
  bool isNotificationsEnabled = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isArabic = context.locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: theme.colorScheme.onSurface,
            size: 20.sp,
          ),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        title: Text(
          TranslationKeys.settings.title.tr(),
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            // 1. My Profile Tile
            SettingsTile(
              icon: Icons.person_outline_rounded,
              title: TranslationKeys.settings.myProfile.tr(),
              onTap: () {},
            ),
            SizedBox(height: 16.h),

            // 2. Language Expandable Tile
            SettingsTile(
              icon: Icons.language_rounded,
              title: TranslationKeys.settings.language.tr(),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isArabic
                        ? TranslationKeys.settings.arabic.tr()
                        : TranslationKeys.settings.english.tr(),
                    style: TextStyle(
                      color: theme.hintColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    isLanguageExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    color: theme.hintColor,
                    size: 20.sp,
                  ),
                ],
              ),
              onTap: () {
                setState(() {
                  isLanguageExpanded = !isLanguageExpanded;
                });
              },
            ),

            if (isLanguageExpanded) ...[
              SizedBox(height: 12.h),

              // English Choice
              LanguageOptionTile(
                title: TranslationKeys.settings.english.tr(),
                isSelected: !isArabic,
                onTap: () async {
                  if (isArabic) {
                    await context.setLocale(const Locale('en', 'US'));
                  }
                },
              ),
              SizedBox(height: 10.h),

              // Arabic Choice
              LanguageOptionTile(
                title: TranslationKeys.settings.arabic.tr(),
                isSelected: isArabic,
                onTap: () async {
                  if (!isArabic) {
                    await context.setLocale(const Locale('ar', 'SA'));
                  }
                },
              ),
              SizedBox(height: 12.h),
            ] else ...[
              SizedBox(height: 16.h),
            ],

            // 3. Notifications Tile
            SettingsTile(
              icon: Icons.notifications_none_rounded,
              title: TranslationKeys.settings.notifications.tr(),
              trailing: Transform.scale(
                scale: 0.85,
                child: CupertinoSwitch(
                  activeColor: AppColors.primary,
                  value: isNotificationsEnabled,
                  onChanged: (bool value) {
                    setState(() {
                      isNotificationsEnabled = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}