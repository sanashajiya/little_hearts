import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../../../../core/cubit/zone_cubit.dart';

class ProfileMetaInfo extends StatelessWidget {
  final String name;
  final int age;
  final String lastSeen;
  final String birthday;
  final String location;

  const ProfileMetaInfo({
    super.key,
    required this.name,
    required this.age,
    required this.lastSeen,
    required this.birthday,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Name, Age, Last Seen Row
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              text: '$name, $age',
              fontSize: 20,
              fontWeight: FontWeightType.bold,
              color: AppColors.white,
            ),
            const SizedBox(width: 16),
            CustomText(
              text: lastSeen,
              fontSize: 12,
              fontWeight: FontWeightType.regular,
              color: AppColors.white,
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Birthday and Follow Button Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: CustomText(
                text: birthday,
                fontSize: 14,
                fontWeight: FontWeightType.regular,
                color: AppColors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: theme.dark,
                border: Border.all(color: AppColors.white, width: 1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const CustomText(
                text: 'Follow',
                fontSize: 14,
                fontWeight: FontWeightType.bold,
                color: AppColors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        // Location
        CustomText(
          text: location,
          fontSize: 14,
          fontWeight: FontWeightType.regular,
          color: AppColors.white,
        ),
      ],
    );
  }
}

