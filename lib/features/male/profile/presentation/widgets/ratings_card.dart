import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class RatingsCard extends StatelessWidget {
  final double rating;
  final int ratingCount;
  final String profileCreatedDate;

  const RatingsCard({
    super.key,
    required this.rating,
    required this.ratingCount,
    required this.profileCreatedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
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
          CustomText(
            text: 'Ratings ($ratingCount)',
            fontSize: 18,
            fontWeight: FontWeightType.bold,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ...List.generate(5, (index) {
                if (index < rating.floor()) {
                  return const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 22,
                  );
                } else if (index < rating) {
                  return const Icon(
                    Icons.star_half,
                    color: Colors.amber,
                    size: 22,
                  );
                } else {
                  return const Icon(
                    Icons.star_border,
                    color: Colors.amber,
                    size: 22,
                  );
                }
              }),
              const SizedBox(width: 4),
              CustomText(
                text: '$rating/5',
                fontSize: 16,
                fontWeight: FontWeightType.bold,
                color: AppColors.textPrimary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          CustomText(
            text: "Profile created on",
            fontSize: 14,
            fontWeight: FontWeightType.semiBold,
            color: AppColors.black,
          ),

          const SizedBox(height: 2),
          CustomText(
            text: profileCreatedDate,
            fontSize: 12,
            fontWeight: FontWeightType.regular,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }
}

