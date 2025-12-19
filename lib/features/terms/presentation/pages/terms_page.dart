import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/custom_text.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const CustomText(
          text: 'Terms & Conditions',
          fontSize: 18,
          fontWeight: FontWeightType.medium,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: const Center(
        child: CustomText(
          text: 'Terms & Conditions Page\n(Coming Soon)',
          textAlign: TextAlign.center,
          fontSize: 18,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
