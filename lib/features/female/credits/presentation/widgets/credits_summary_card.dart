import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/zone_theme.dart';

class CreditsSummaryCard extends StatelessWidget {
  final int totalStars;
  final int convertedAmount;

  const CreditsSummaryCard({
    super.key,
    required this.totalStars,
    required this.convertedAmount,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: zoneTheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.white,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/icons/star.png',
                width: 32,
                height: 32,
              ),
              CustomText(
                text: '120 ',
                fontSize: 20,
                fontWeight: FontWeightType.bold,
                color: AppColors.white,
              ),
              const SizedBox(width: 8),
              Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.swap_horiz,
                  color: AppColors.black,
                  size: 28,
                ),
              ),
              const SizedBox(width: 12),
              CustomText(
                text: '₹ 120',
                fontSize: 20,
                fontWeight: FontWeightType.bold,
                color: AppColors.white,
              ),
              
            ],
          ),
          const SizedBox(height: 16),
          CustomText(
            text: 'Conversion Rate',
            fontSize: 14,
            fontWeight: FontWeightType.medium,
            color: AppColors.white,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/star.png',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              CustomText(
            text: '1  Star = 1  Rupee',
            fontSize: 14,
            fontWeight: FontWeightType.medium,
            color: AppColors.white,
          ),
            ],

          ),
          
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    final str = number.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) {
        buffer.write(',');
      }
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}

