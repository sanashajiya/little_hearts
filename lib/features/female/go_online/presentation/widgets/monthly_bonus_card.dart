import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/zone_theme.dart';

class MonthlyBonusCard extends StatelessWidget {
  final String period;

  const MonthlyBonusCard({
    super.key,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/icons/star.png',
                width: 28,
                height: 28,
              ),
              const SizedBox(width: 8),
              const CustomText(
                text: 'Monthly Bonus',
                fontSize: 16,
                fontWeight: FontWeightType.regular,
                color: Colors.black,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0),
            child: CustomText(
              text: '($period)',
              fontSize: 10,
              fontWeight: FontWeightType.medium,
              color: Colors.black.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }
}

