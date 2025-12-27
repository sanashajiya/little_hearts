import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

/// Live Badge Widget
class LiveBadge extends StatelessWidget {
  final int viewerCount;
  final double fontSize;
  final double padding;

  const LiveBadge({
    super.key,
    required this.viewerCount,
    this.fontSize = 12,
    this.padding = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 12,right: 250),
      padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.hangoutModeDark
        )
      ),
      child: Row(
        // mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          CustomText(
            text: 'Live($viewerCount)',
            fontSize: fontSize,
            fontWeight: FontWeightType.semiBold,
            color: AppColors.textPrimary,
          ),
        ],
      ),
    );
  }
}

