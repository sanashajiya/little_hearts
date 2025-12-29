import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';

class ProfileActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final int pricePerMin;

  const ProfileActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.pricePerMin,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: theme.dark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.white, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.star, color: Colors.amber, size: 14),
              const SizedBox(width: 4),
              CustomText(
                text: '$pricePerMin/min',
                fontSize: 11,
                fontWeight: FontWeightType.regular,
                color: AppColors.white,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
             Icon(icon, color: AppColors.white, size: 16),
              const SizedBox(width: 8),
              CustomText(
                text: label,
                fontSize: 12,
                fontWeight: FontWeightType.medium,
                color: AppColors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}



