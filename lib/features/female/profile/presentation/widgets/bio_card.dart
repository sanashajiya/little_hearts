import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class BioCard extends StatelessWidget {
  final String bio;

  const BioCard({
    super.key,
    required this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Bio',
            fontSize: 18,
            fontWeight: FontWeightType.bold,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 4),
          CustomText(
            text: bio,
            fontSize: 12,
            fontWeight: FontWeightType.regular,
            color: AppColors.black,
            maxLines: null,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}




