import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class HangoutProfileSummaryRow extends StatelessWidget {
  final String profileImage;
  final int followersCount;
  final int followingCount;

  const HangoutProfileSummaryRow({
    super.key,
    required this.profileImage,
    required this.followersCount,
    required this.followingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Profile Image
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.white,
              width: 3,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              profileImage,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 24),
        // Followers
        Column(
          children: [
            CustomText(
              text: followersCount.toString(),
              fontSize: 20,
              fontWeight: FontWeightType.bold,
              color: AppColors.white,
            ),
            const SizedBox(height: 4),
            const CustomText(
              text: 'Followers',
              fontSize: 14,
              fontWeight: FontWeightType.medium,
              color: AppColors.white,
            ),
          ],
        ),
        const SizedBox(width: 32),
        // Following
        Column(
          children: [
            CustomText(
              text: followingCount.toString(),
              fontSize: 20,
              fontWeight: FontWeightType.bold,
              color: AppColors.white,
            ),
            const SizedBox(height: 4),
            const CustomText(
              text: 'Following',
              fontSize: 14,
              fontWeight: FontWeightType.medium,
              color: AppColors.white,
            ),
          ],
        ),
      ],
    );
  }
}


