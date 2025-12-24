import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../widgets/terms_section.dart';

class TermsConditionsScreen extends StatelessWidget {
  const TermsConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0.5, // 👈 adds shadow
        shadowColor: Colors.white.withOpacity(0.8),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        title: const CustomText(
          text: 'Terms & Conditions',
          fontSize: 18,
          fontWeight: FontWeightType.bold,
          color: AppColors.textPrimary,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TermsSection(
              title: 'Acceptance of Terms',
              points: [
                'By accessing and using this application, you accept and agree to be bound by the terms and provision of this agreement.',
                'If you do not agree to abide by the above, please do not use this service.',
              ],
            ),
            const SizedBox(height: 24),
            TermsSection(
              title: 'Eligibility',
              points: [
                'You must be at least 18 years old to use this service.',
                'You must be legally capable of entering into binding contracts.',
                'You must not be prohibited from using the service under applicable laws.',
              ],
            ),
            const SizedBox(height: 24),
            TermsSection(
              title: 'Account Registration',
              points: [
                'You are responsible for maintaining the confidentiality of your account credentials.',
                'You agree to provide accurate and complete information during registration.',
                'You are responsible for all activities that occur under your account.',
              ],
            ),
            const SizedBox(height: 24),
            TermsSection(
              title: 'User Conduct',
              points: [
                'You agree not to use the service for any unlawful purpose.',
                'You will not harass, abuse, or harm other users.',
                'You will not post false, misleading, or defamatory content.',
                'You will respect the privacy and rights of other users.',
              ],
            ),
            const SizedBox(height: 24),
            TermsSection(
              title: 'Content Ownership & Rights',
              points: [
                'You retain ownership of content you post, but grant us a license to use it.',
                'We reserve the right to remove any content that violates these terms.',
                'You may not use our content without prior written permission.',
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
