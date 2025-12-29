import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class ProfileImagePicker extends StatelessWidget {
  const ProfileImagePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.borderLight,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/female4.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 3,
                ),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: AppColors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}




