import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class RankBadge extends StatelessWidget {
  final int rank;
  final Color badgeColor;
  final double size;

  const RankBadge({
    super.key,
    required this.rank,
    required this.badgeColor,
    this.size = 32,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: badgeColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: Center(
        child: CustomText(
          text: rank.toString(),
          fontSize: size * 0.4,
          fontWeight: FontWeightType.bold,
          color: AppColors.white,
        ),
      ),
    );
  }
}


