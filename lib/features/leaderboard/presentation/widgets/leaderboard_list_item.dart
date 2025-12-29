import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/leaderboard_type.dart';
import 'profile_avatar.dart';
import 'rank_badge.dart';

class LeaderboardListItem extends StatelessWidget {
  final LeaderboardEntry entry;
  final LeaderboardType type;
  final Color badgeColor;

  const LeaderboardListItem({
    super.key,
    required this.entry,
    required this.type,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          RankBadge(
            rank: entry.rank,
            badgeColor: badgeColor,
            size: 32,
          ),
          const SizedBox(width: 12),
          ProfileAvatar(
            imagePath: entry.profileImage,
            size: 48,
            showCrown: false,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomText(
              text: entry.name,
              fontSize: 14,
              fontWeight: FontWeightType.medium,
              color: AppColors.textPrimary,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Image.asset(
                type == LeaderboardType.topEarner
                    ? 'assets/icons/coin.png'
                    : 'assets/icons/star.png',
                width: 18,
                height: 18,
              ),
              const SizedBox(width: 4),
              CustomText(
                text: entry.score.toString(),
                fontSize: 14,
                fontWeight: FontWeightType.bold,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


