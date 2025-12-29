import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

/// Hangout AppBar Widget
class HangoutAppBar extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onCreateTap;

  const HangoutAppBar({
    super.key,
    this.onBack,
    this.onCreateTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18),
          onPressed: onBack ?? () => context.go('/home'),
        ),
        const CustomText(
          text: 'Hangout Zone',
          fontSize: 20,
          fontWeight: FontWeightType.semiBold,
          color: Colors.black,
        ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => context.push('/hangout/credits'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF9C3),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/coin.png',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        const CustomText(
                          text: '200',
                          fontSize: 14,
                          fontWeight: FontWeightType.bold,
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: onCreateTap,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.hangoutMode,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.add,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


