import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppColors.textPrimary,
        ),
        const SizedBox(width: 12),
        CustomText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeightType.medium,
          color: AppColors.textPrimary,
        ),
      ],
    );
  }
}




