import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/zone_theme.dart';
import '../../../../core/cubit/zone_cubit.dart';

class RecentsHeader extends StatelessWidget {
  final int balance;
  final VoidCallback onRechargeTap;

  const RecentsHeader({
    super.key,
    required this.balance,
    required this.onRechargeTap,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          decoration: BoxDecoration(
            color: theme.primary,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: 'Available Coins Balance',
                      fontSize: 14,
                      fontWeight: FontWeightType.medium,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/coin.png',
                          width: 44,
                          height: 44,
                        ),
                        const SizedBox(width: 8),
                        CustomText(
                          text: balance.toString(),
                          fontSize: 36,
                          fontWeight: FontWeightType.bold,
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SizedBox(
            width: double.infinity,
            height: 46,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primary,
                foregroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: Colors.white.withOpacity(0.7)),
                ),
              ),
              onPressed: onRechargeTap,
              child: const CustomText(
                text: 'Recharge',
                fontSize: 16,
                fontWeight: FontWeightType.semiBold,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}


