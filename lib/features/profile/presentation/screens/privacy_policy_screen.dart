import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/localization/translation_keys.dart';
import 'package:ecommerce/core/utils/app_colors.dart';
import 'package:ecommerce/features/profile/presentation/widgets/policy_expansion_tile.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      appBar: AppBar(
        title: Text(
          TranslationKeys.privacyPolicy.title.tr(),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        ),
        centerTitle: true,
        backgroundColor: theme.colorScheme.surface,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TranslationKeys.privacyPolicy.headerTitle.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    TranslationKeys.privacyPolicy.lastUpdated.tr(),
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.hintColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    TranslationKeys.privacyPolicy.headerSubtitle.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            PolicyExpansionTile(
              title: TranslationKeys.privacyPolicy.section1Title.tr(),
              icon: Icons.assignment_outlined,
              primaryColor: AppColors.primary,
              content: TranslationKeys.privacyPolicy.section1Content.tr(),
            ),
            PolicyExpansionTile(
              title: TranslationKeys.privacyPolicy.section2Title.tr(),
              icon: Icons.shield_outlined,
              primaryColor: AppColors.primary,
              content: TranslationKeys.privacyPolicy.section2Content.tr(),
            ),
            PolicyExpansionTile(
              title: TranslationKeys.privacyPolicy.section3Title.tr(),
              icon: Icons.share_outlined,
              primaryColor: AppColors.primary,
              content: TranslationKeys.privacyPolicy.section3Content.tr(),
            ),
            PolicyExpansionTile(
              title: TranslationKeys.privacyPolicy.section4Title.tr(),
              icon: Icons.lock_outline,
              primaryColor: AppColors.primary,
              content: TranslationKeys.privacyPolicy.section4Content.tr(),
            ),
            PolicyExpansionTile(
              title: TranslationKeys.privacyPolicy.section5Title.tr(),
              icon: Icons.person_outline,
              primaryColor: AppColors.primary,
              content: TranslationKeys.privacyPolicy.section5Content.tr(),
            ),

            const SizedBox(height: 24),

            // Support Contact Card
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                    child: const Icon(
                      Icons.support_agent,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TranslationKeys.privacyPolicy.haveQuestions.tr(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          TranslationKeys.privacyPolicy.contactSupportSubtitle
                              .tr(),
                          style: TextStyle(
                            fontSize: 12,
                            color: theme.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      TranslationKeys.privacyPolicy.contactButton.tr(),
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}