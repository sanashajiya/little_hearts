import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class LeaderboardAppBar extends StatelessWidget implements PreferredSizeWidget {
   final Color backgroundColor;
  final VoidCallback? onBackPressed;

  const LeaderboardAppBar({
    super.key,
   required this.backgroundColor,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.white,
        ),
        onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: const CustomText(
        text: 'Leader Board',
        fontSize: 18,
        fontWeight: FontWeightType.bold,
        color: AppColors.white,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

