import 'package:flutter/material.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: CustomText(
        text: title,
        fontSize: 18,
        fontWeight: FontWeightType.bold,
        color: AppColors.textPrimary,
      ),
    );
  }
}

