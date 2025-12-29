import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/leaderboard_type.dart';

class LeaderboardTypeTabs extends StatelessWidget {
  final LeaderboardType selectedType;
  final Color activeColor;
  final Function(LeaderboardType) onTypeChanged;

  const LeaderboardTypeTabs({
    super.key,
    required this.selectedType,
    required this.activeColor,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _TypeTab(
              label: 'Top Earner',
              isActive: selectedType == LeaderboardType.topEarner,
              activeColor: activeColor,
              onTap: () => onTypeChanged(LeaderboardType.topEarner),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: _TypeTab(
              label: 'Top Gifter',
              isActive: selectedType == LeaderboardType.topGifter,
              activeColor: activeColor,
              onTap: () => onTypeChanged(LeaderboardType.topGifter),
            ),
          ),
        ],
      ),
    );
  }
}

class _TypeTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  const _TypeTab({
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CustomText(
            text: label,
            fontSize: 14,
            fontWeight: isActive ? FontWeightType.bold : FontWeightType.medium,
            color: isActive ? activeColor : AppColors.black,
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            decoration: BoxDecoration(
              color: isActive ? activeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ],
      ),
    );
  }
}


