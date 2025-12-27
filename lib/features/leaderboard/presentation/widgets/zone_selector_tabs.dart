import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/leaderboard_zone.dart';

class ZoneSelectorTabs extends StatelessWidget {
  final LeaderboardZone selectedZone;
  final Color activeColor;
  final Function(LeaderboardZone) onZoneChanged;

  const ZoneSelectorTabs({
    super.key,
    required this.selectedZone,
    required this.activeColor,
    required this.onZoneChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _ZoneTab(
              label: 'Frnd Zone',
              isActive: selectedZone == LeaderboardZone.friend,
              activeColor: activeColor,
              onTap: () => onZoneChanged(LeaderboardZone.friend),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ZoneTab(
              label: 'Date Mode',
              isActive: selectedZone == LeaderboardZone.date,
              activeColor: activeColor,
              onTap: () => onZoneChanged(LeaderboardZone.date),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _ZoneTab(
              label: 'Hangout Zone',
              isActive: selectedZone == LeaderboardZone.hangout,
              activeColor: activeColor,
              onTap: () => onZoneChanged(LeaderboardZone.hangout),
            ),
          ),
        ],
      ),
    );
  }
}

class _ZoneTab extends StatelessWidget {
  final String label;
  final bool isActive;
  final Color activeColor;
  final VoidCallback onTap;

  const _ZoneTab({
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isActive ? activeColor : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isActive ? activeColor : AppColors.borderLight,
          ),
        ),
        child: Center(
          child: CustomText(
            text: label,
            fontSize: 12,
            fontWeight:
                isActive ? FontWeightType.bold : FontWeightType.medium,
            color: isActive ? AppColors.white : AppColors.black,
          ),
        ),
      ),
    );
  }
}

