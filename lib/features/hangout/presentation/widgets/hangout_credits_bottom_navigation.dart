import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

/// Hangout Credits Bottom Navigation Bar
/// Shows Home, Video Zone, Audio Zone with hangout theme
class HangoutCreditsBottomNavigation extends StatelessWidget {
  const HangoutCreditsBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildTabItem(
              context: context,
              icon: Icons.home,
              label: 'Home',
              isSelected: false,
              onTap: () => context.go('/home'),
            ),
            _buildTabItem(
              context: context,
              icon: Icons.videocam,
              label: 'Video Zone',
              isSelected: false,
              onTap: () => context.go('/hangout/zone'),
            ),
            _buildTabItem(
              context: context,
              icon: Icons.mic,
              label: 'Audio Zone',
              isSelected: false,
              onTap: () => context.go('/hangout/zone'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.hangoutMode : AppColors.textSecondary,
                size: 24,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: label,
                fontSize: 12,
                fontWeight: FontWeightType.medium,
                color: isSelected ? AppColors.hangoutMode : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

