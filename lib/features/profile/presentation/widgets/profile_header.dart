import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/profile_menu.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.white,
              size: 20,
            ),
            onPressed: () => context.pop(),
          ),
          // const CustomText(
          //   text: 'Self profile screen',
          //   fontSize: 18,
          //   fontWeight: FontWeightType.bold,
          //   color: AppColors.white,
          // ),
          ProfileMenu(),
        ],
      ),
    );
  }
}

