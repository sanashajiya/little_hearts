import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

/// Language Badge Widget (appears over profile image)
class LanguageBadge extends StatelessWidget {
  final String language;

  const LanguageBadge({
    super.key,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 6,
      left: 8,
      child: CustomText(
        text: language,
        fontSize: 12,
        fontWeight: FontWeightType.semiBold,
        color: AppColors.white,
      ),
    );
  }
}

