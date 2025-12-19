import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/utils/app_mediaquery.dart';
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
            Text(
              content.title,
              style: GoogleFonts.nunito(
                fontSize: getProportionateScreenHeight(32),
                fontWeight: FontWeight.bold,
                color: AppColors.textWhite,
                fontStyle: FontStyle.italic,
                shadows: const [
                  Shadow(
                    offset: Offset(2, 2),
                    blurRadius: 4,
                    color: Colors.black26,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Subtitle
            Text(
              content.subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                fontSize: getProportionateScreenHeight(14),
                fontWeight: FontWeight.w500,
                color: AppColors.textWhite.withValues(alpha: 0.9),
                fontStyle: FontStyle.italic,
              ),
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
