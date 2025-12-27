import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class HangoutViewProfileRatingsCard extends StatelessWidget {
  final double rating;
  final int ratingCount;
  final int conversationMinutes;
  final int starsGifted;
  final String followingSince;

  const HangoutViewProfileRatingsCard({
    super.key,
    required this.rating,
    required this.ratingCount,
    required this.conversationMinutes,
    required this.starsGifted,
    required this.followingSince,
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
          // Top Section: Ratings
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
              const SizedBox(width: 8),
              CustomText(
                text: '$rating/5',
                fontSize: 16,
                fontWeight: FontWeightType.bold,
                color: AppColors.textPrimary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Bottom Section: Stats Cards
          Row(
            children: [
              Expanded(
                child: _buildStatCard(
                  label: 'Conversation Minutes',
                  value: '$conversationMinutes Mins',
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildStatCard(
                  label: 'Stars Gifted',
                  value: starsGifted.toString(),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _buildStatCard(
                  label: 'Following Since',
                  value: followingSince,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.hangoutMode,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomText(
            text: label,
            fontSize: 10,
            fontWeight: FontWeightType.medium,
            color: AppColors.white,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          CustomText(
            text: value,
            fontSize: 13,
            fontWeight: FontWeightType.bold,
            color: AppColors.white,
          ),
        ],
      ),
    );
  }
}

