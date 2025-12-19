import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/custom_text.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const CustomText(
          text: 'Profile Setup',
          fontSize: 18,
          fontWeight: FontWeightType.medium,
          color: AppColors.white,
        ),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
      ),
      body: const Center(
        child: CustomText(
          text: 'Profile Setup Screen\n(Coming Soon)',
          textAlign: TextAlign.center,
          fontSize: 18,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
