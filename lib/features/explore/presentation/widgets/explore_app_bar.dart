import 'package:flutter/material.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class ExploreAppBar extends StatelessWidget {
  final VoidCallback onBack;

  const ExploreAppBar({super.key, required this.onBack});

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
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Color(0xFFFEF9C3),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                children:  [
                 Image.asset( 
                    'assets/icons/coin.png',
                    width: 18,
                    height: 18,
                  ),
                  SizedBox(width: 4),
                  CustomText(
                    text: '200',
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
              width: 23,
              height: 23,
            ),
          ],
        ),
      ],
    );
  }
}


