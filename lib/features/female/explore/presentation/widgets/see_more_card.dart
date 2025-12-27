import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class SeeMoreCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const SeeMoreCard({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person_outline,
                size: 32,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: title,
                textAlign: TextAlign.center,
                fontSize: 12,
                fontWeight: FontWeightType.bold,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



