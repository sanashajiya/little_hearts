import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

/// Waitlist Item Widget
class WaitlistItem extends StatelessWidget {
  final String name;

  const WaitlistItem({
    super.key,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: CustomText(
        text: '$name joined waitlist',
        fontSize: 14,
        fontWeight: FontWeightType.medium,
        color: AppColors.textSecondary,
      ),
    );
  }
}

