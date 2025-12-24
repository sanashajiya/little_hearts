import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../bloc/recents_event.dart';

class RecentsTabs extends StatelessWidget {
  final RecentsTab selectedTab;
  final VoidCallback onTransactionsTap;
  final VoidCallback onCallsTap;
  final VoidCallback onCalendarTap;

  const RecentsTabs({
    super.key,
    required this.selectedTab,
    required this.onTransactionsTap,
    required this.onCallsTap,
    required this.onCalendarTap,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTab(
                label: 'Transaction History',
                isSelected: selectedTab == RecentsTab.transactions,
                onTap: onTransactionsTap,
                theme: theme,
              ),
              const SizedBox(width: 24),
              _buildTab(
                label: 'Call History',
                isSelected: selectedTab == RecentsTab.calls,
                onTap: onCallsTap,
                theme: theme,
              ),
              
            ],
            
          ),
          const SizedBox(height: 10),
          // const Spacer(),
                GestureDetector(
                  onTap: onCalendarTap,
                  child: Image.asset(
                    'assets/icons/calendar.png',
                    width: 26,
                    height: 26,
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required ZoneTheme theme,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: label,
            fontSize: 13,
            fontWeight:
                isSelected ? FontWeightType.bold : FontWeightType.medium,
            color: isSelected ? AppColors.black : AppColors.textPrimary,
          ),
          const SizedBox(height: 4),
          Container(
            width: 90,
            height: 2,
            decoration: BoxDecoration(
              color: isSelected ? theme.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}


