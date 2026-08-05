import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce/core/localization/translation_keys.dart';
import 'package:ecommerce/features/profile/presentation/widgets/policy_expansion_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF1976D2);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          TranslationKeys.privacyPolicy.title.tr(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
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
                color: primaryBlue.withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: primaryBlue.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    TranslationKeys.privacyPolicy.headerTitle.tr(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    TranslationKeys.privacyPolicy.lastUpdated.tr(),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    TranslationKeys.privacyPolicy.headerSubtitle.tr(),
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
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
              primaryColor: primaryBlue,
              content: TranslationKeys.privacyPolicy.section1Content.tr(),
            ),
            PolicyExpansionTile(
              title: TranslationKeys.privacyPolicy.section2Title.tr(),
              icon: Icons.shield_outlined,
              primaryColor: primaryBlue,
              content: TranslationKeys.privacyPolicy.section2Content.tr(),
            ),
            PolicyExpansionTile(
              title: TranslationKeys.privacyPolicy.section3Title.tr(),
              icon: Icons.share_outlined,
              primaryColor: primaryBlue,
              content: TranslationKeys.privacyPolicy.section3Content.tr(),
            ),
            PolicyExpansionTile(
              title: TranslationKeys.privacyPolicy.section4Title.tr(),
              icon: Icons.lock_outline,
              primaryColor: primaryBlue,
              content: TranslationKeys.privacyPolicy.section4Content.tr(),
            ),
            PolicyExpansionTile(
              title: TranslationKeys.privacyPolicy.section5Title.tr(),
              icon: Icons.person_outline,
              primaryColor: primaryBlue,
              content: TranslationKeys.privacyPolicy.section5Content.tr(),
            ),

            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: primaryBlue.withOpacity(0.1),
                    child: const Icon(Icons.support_agent, color: primaryBlue),
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
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
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
                        color: primaryBlue,
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
