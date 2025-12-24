import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/zone_theme.dart';
import '../../../../core/cubit/zone_cubit.dart';

class PreviousStoriesCard extends StatelessWidget {
  final List<String> stories;

  const PreviousStoriesCard({
    super.key,
    required this.stories,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

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
          const CustomText(
            text: 'Previous Stories',
            fontSize: 18,
            fontWeight: FontWeightType.bold,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 64,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: stories.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.primary,
                      width: 1.5,
                    ),
                  ),
                  padding: const EdgeInsets.all(3),
                  child: ClipOval(
                    child: Image.asset(
                      stories[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

