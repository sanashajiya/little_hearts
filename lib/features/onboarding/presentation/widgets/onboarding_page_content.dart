import 'package:flutter/material.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/onboarding_content.dart';

class OnboardingPageContent extends StatelessWidget {
  final OnboardingContent content;

  const OnboardingPageContent({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: content.backgroundColor,
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60),
            // Title
            CustomText(
              text: content.title,
              fontWeight: FontWeightType.bold,
              fontSize: 32,
              color: AppColors.textWhite,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Subtitle
             CustomText(
            text: content.subtitle,
            fontWeight: FontWeightType.medium,
            fontSize: 14,
            color: AppColors.textWhite.withValues(alpha: 0.9),
            textAlign: TextAlign.center,
            maxLines: 3,
          ),
            const SizedBox(height: 20),
            // Image
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Image.asset(content.image, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
