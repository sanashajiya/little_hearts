import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class UnblockButton extends StatelessWidget {
  final VoidCallback onTap;

  const UnblockButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          color: AppColors.greyLight,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const CustomText(
          text: 'Unblock',
          fontSize: 14,
          fontWeight: FontWeightType.medium,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}




