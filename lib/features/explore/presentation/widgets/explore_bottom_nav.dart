import 'package:flutter/material.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class ExploreBottomNav extends StatelessWidget {
  final VoidCallback onHomeTap;
  final VoidCallback onExploreTap;
  final VoidCallback onRecentsTap;
  final VoidCallback onProfileTap;

  const ExploreBottomNav({
    super.key,
    required this.onHomeTap,
    required this.onExploreTap,
    required this.onRecentsTap,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
               const SizedBox(width: 20),
              _navItem(
                icon: Icons.home_outlined,
                label: 'Home',
                isSelected: false,
                onTap: onHomeTap,
              ),

              const SizedBox(width: 42),
              _navItem(
                icon: Icons.explore_outlined,
                label: 'Explore',
                isSelected: true,
                onTap: onExploreTap,
              ),
              const SizedBox(width: 105),
              _navItem(
                icon: Icons.history,
                label: 'Recents',
                isSelected: false,
                onTap: onRecentsTap,
              ),
              const SizedBox(width: 35),
              _navItem(
                icon: Icons.person_outline,
                label: 'Profile',
                isSelected: false,
                onTap: onProfileTap,
              ),
            ],
          ),
          Positioned(
            bottom: 8,
            child: GestureDetector(
              onTap: onExploreTap,
              child: Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  color: AppColors.friendMode,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.friendModeDark,
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.handshake,
                      color: Colors.white,
                      size: 26,
                    ),
                    SizedBox(height: 2),
                    CustomText(
                      text: 'Make a Frd',
                      fontSize: 9,
                      fontWeight: FontWeightType.bold,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final color = isSelected ? AppColors.friendModeDark : AppColors.textSecondary;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 2),
          CustomText(
            text: label,
            fontSize: 10,
            fontWeight: FontWeightType.medium,
            color: color,
          ),
        ],
      ),
    );
  }
}


