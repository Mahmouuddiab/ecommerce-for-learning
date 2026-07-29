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
        title: const Text(
          'Privacy Policy',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
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
                  const Text(
                    'Your Privacy Matters',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: primaryBlue,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Last updated: July 2026',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'We are committed to protecting your personal information and your right to privacy. Please read this policy carefully.',
                    style: TextStyle(fontSize: 14, color: Colors.black, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Accordion Sections
            const PolicyExpansionTile(
              title: '1. Information We Collect',
              icon: Icons.assignment_outlined,
              primaryColor: primaryBlue,
              content:
              'We collect personal information that you provide to us such as name, email address, phone number, shipping address, and payment details when you register, make a purchase, or contact our support team.',
            ),
            const PolicyExpansionTile(
              title: '2. How We Use Your Information',
              icon: Icons.shield_outlined,
              primaryColor: primaryBlue,
              content:
              'Your information is used to process orders, manage your account, send transaction updates, deliver customer support, and improve our store experience. We may also send promotional offers if you opt-in.',
            ),
            const PolicyExpansionTile(
              title: '3. Data Sharing & Third Parties',
              icon: Icons.share_outlined,
              primaryColor: primaryBlue,
              content:
              'We only share information with trusted third-party service providers (such as payment gateways and logistics/delivery partners) strictly necessary to fulfill your orders and services.',
            ),
            const PolicyExpansionTile(
              title: '4. Data Security & Storage',
              icon: Icons.lock_outline,
              primaryColor: primaryBlue,
              content:
              'We implement standard security measures, including encryption and secure server infrastructure, to prevent unauthorized access, disclosure, or modification of your personal data.',
            ),
            const PolicyExpansionTile(
              title: '5. Your Rights & Choices',
              icon: Icons.person_outline,
              primaryColor: primaryBlue,
              content:
              'You have the right to view, update, or request the deletion of your personal data at any time through your profile settings or by contacting customer support.',
            ),

            const SizedBox(height: 24),

            // Contact Us Section
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
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Have questions?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Contact our privacy support team',
                          style: TextStyle(fontSize: 12, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Action for support contact (e.g., mailto or navigate to support screen)
                    },
                    child: const Text(
                      'Contact',
                      style: TextStyle(
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