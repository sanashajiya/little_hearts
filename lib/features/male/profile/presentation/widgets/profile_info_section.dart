import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../models/profile_data.dart';

class ProfileInfoSection extends StatelessWidget {
  final ProfileData profile;

  const ProfileInfoSection({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Profile Image
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/male2.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () =>
                    context.push('/followers', extra: {'type': 'followers'}),
                child: Column(
                  children: [
                    CustomText(
                      text: '${profile.followersCount}',
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
              ),
              const SizedBox(width: 40),
              GestureDetector(
                onTap: () =>
                    context.push('/followers', extra: {'type': 'following'}),
                child: Column(
                  children: [
                    CustomText(
                      text: '${profile.followingCount}',
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
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Name & Age
        CustomText(
          text: '${profile.name}, ${profile.age}',
          fontSize: 22,
          fontWeight: FontWeightType.bold,
          color: AppColors.white,
        ),
        const SizedBox(height: 6),
        // Last Seen
        CustomText(
          text: profile.lastSeen,
          fontSize: 12,
          fontWeight: FontWeightType.regular,
          color: AppColors.white,
        ),
        const SizedBox(height: 4),
        // Location
        CustomText(
          text: profile.location,
          fontSize: 12,
          fontWeight: FontWeightType.regular,
          color: AppColors.white,
        ),
        const SizedBox(height: 24),
        // Followers & Following
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            
          ],
        ),
      ],
    );
  }
}
