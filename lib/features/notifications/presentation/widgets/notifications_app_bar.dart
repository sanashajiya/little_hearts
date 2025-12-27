import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const NotificationsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.textPrimary,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
      centerTitle: true,
      title: const CustomText(
        text: 'Notifications',
        fontSize: 18,
        fontWeight: FontWeightType.bold,
        color: AppColors.textPrimary,
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(
          height: 1,
          color: AppColors.borderLight,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}

