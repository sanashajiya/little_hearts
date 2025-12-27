import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/hangout_user.dart';
import 'language_badge.dart';
import 'rating_stars.dart';
import 'topic_chip.dart';

/// Hangout User Card Widget
class HangoutUserCard extends StatelessWidget {
  final HangoutUser user;
  final VoidCallback? onTap;

  const HangoutUserCard({
    super.key,
    required this.user,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image with Language Badge and Icon
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.asset(
                    user.profileImage,
                    width: double.infinity,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                // Language Badge
                LanguageBadge(language: user.language),
                // Video/Audio Icon
                Positioned(
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      user.isAudio ? Icons.mic : Icons.videocam,
                      color: AppColors.white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
            // User Info
            Padding(
              padding: const EdgeInsets.all(4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name
                  Row(
                    children: [
                      CustomText(
                        text: user.name,
                        fontSize: 14,
                        fontWeight: FontWeightType.bold,
                        color: AppColors.textPrimary,
                      ),
                      const SizedBox(width: 4),
                       RatingStars(rating: user.rating),
                    ],
                  ),
                  const SizedBox(height: 4),
                  // Topic Chip
                  TopicChip(topic: user.topic),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

