import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class FemaleExploreAppBar extends StatelessWidget {
  final VoidCallback onBack;

  const FemaleExploreAppBar({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
          onPressed: onBack,
        ),
        const CustomText(
          text: 'Explore',
          fontSize: 20,
          fontWeight: FontWeightType.semiBold,
          color: Colors.white,
        ),
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/icons/star.png',
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 4),
                  CustomText(
                    text: '40',
                    fontSize: 14,
                    fontWeight: FontWeightType.bold,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Image.asset(
              'assets/icons/chat.png',
              width: 24,
              height: 24,
            ),
          ],
        ),
      ],
    );
  }
}



