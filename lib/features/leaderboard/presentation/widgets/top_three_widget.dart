import 'package:flutter/material.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/leaderboard_type.dart';
import 'profile_avatar.dart';
import 'rank_badge.dart';

class TopThreeWidget extends StatelessWidget {
  final List<LeaderboardEntry> topThree;
  final LeaderboardType type;
  final Color zoneColor;

  const TopThreeWidget({
    super.key,
    required this.topThree,
    required this.type,
    required this.zoneColor,
  });

  @override
  Widget build(BuildContext context) {
    if (topThree.isEmpty) {
      return const SizedBox.shrink();
    }

    final rank1 = topThree.isNotEmpty ? topThree[0] : null;
    final rank2 = topThree.length > 1 ? topThree[1] : null;
    final rank3 = topThree.length > 2 ? topThree[2] : null;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Rank 2
          if (rank2 != null)
            Expanded(
              child: _TopThreeItem(
                entry: rank2,
                type: type,
                zoneColor: zoneColor,
                isCenter: false,
              ),
            ),
          // Rank 1 (center, bigger)
          if (rank1 != null)
            Expanded(
              child: _TopThreeItem(
                entry: rank1,
                type: type,
                zoneColor: zoneColor,
                isCenter: true,
              ),
            ),
          // Rank 3
          if (rank3 != null)
            Expanded(
              child: _TopThreeItem(
                entry: rank3,
                type: type,
                zoneColor: zoneColor,
                isCenter: false,
              ),
            ),
        ],
      ),
    );
  }
}

class _TopThreeItem extends StatelessWidget {
  final LeaderboardEntry entry;
  final LeaderboardType type;
  final Color zoneColor;
  final bool isCenter;

  const _TopThreeItem({
    required this.entry,
    required this.type,
    required this.zoneColor,
    required this.isCenter,
  });

  @override
  Widget build(BuildContext context) {
    final avatarSize = isCenter ? 72.0 : 55.0;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            ProfileAvatar(
              imagePath: entry.profileImage,
              size: avatarSize,
              showCrown: isCenter && entry.rank == 1,
            ),
            if (!isCenter)
              Positioned(
                bottom: -14,
                child: RankBadge(
                  rank: entry.rank,
                  badgeColor: zoneColor,
                  size: 24,
                ),
              ),
              if (isCenter)
            Positioned(
                bottom: -12,
                child: RankBadge(
                  rank: entry.rank,
                  badgeColor: zoneColor,
                  size: 24,
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        CustomText(
          text: entry.name,
          fontSize: 12,
          fontWeight: FontWeightType.bold,
          color: AppColors.textPrimary,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              type == LeaderboardType.topEarner
                  ? 'assets/icons/coin.png'
                  : 'assets/icons/star.png',
              width: 16,
              height: 16,
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
    );
  }
}
