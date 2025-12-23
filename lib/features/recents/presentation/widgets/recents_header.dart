import 'package:flutter/material.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

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
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 26, vertical: 24),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
          decoration: BoxDecoration(
            color: AppColors.friendMode,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomText(
                      text: 'Available Coins Balance',
                      fontSize: 12,
                      fontWeight: FontWeightType.medium,
                      color: AppColors.white,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/coin.png',
                          width: 26,
                          height: 26,
                        ),
                        const SizedBox(width: 8),
                        CustomText(
                          text: balance.toString(),
                          fontSize: 26,
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
                backgroundColor: AppColors.friendMode,
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


