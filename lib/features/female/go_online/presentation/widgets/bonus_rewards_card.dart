import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../domain/entities/bonus_reward.dart';

class BonusRewardsCard extends StatelessWidget {
  final List<BonusReward> rewards;

  const BonusRewardsCard({
    super.key,
    required this.rewards,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: zoneTheme.primary,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: zoneTheme.dark,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...rewards.map((reward) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/star.png',
                      width: 28,
                      height: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: CustomText(
                        text: '${reward.stars} – ${reward.reward}',
                        fontSize: 14,
                        fontWeight: FontWeightType.medium,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

