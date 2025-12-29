import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

/// Topic Chip Widget
class TopicChip extends StatelessWidget {
  final String topic;

  const TopicChip({
    super.key,
    required this.topic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2,left: 4,right: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.hangoutMode,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: 'Topic:  ',
            fontSize: 12,
            fontWeight: FontWeightType.semiBold,
            color: AppColors.black,
          ),
          CustomText(
            text: topic,
            fontSize: 12,
            fontWeight: FontWeightType.semiBold,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}


