import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

/// Hangout Bottom Navigation Widget
class HangoutBottomNavigation extends StatelessWidget {
  final bool isAudio;
  final Function(bool) onTabChanged;

  const HangoutBottomNavigation({
    super.key,
    required this.isAudio,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
              icon: Icons.home,
              label: 'Home',
              isSelected: false,
              onTap: () {
                context.go('/home');
              },
            ),
            _buildTabItem(
              icon: Icons.videocam,
              label: 'Video Zone',
              isSelected: !isAudio,
              onTap: () => onTabChanged(false),
            ),
            _buildTabItem(
              icon: Icons.mic,
              label: 'Audio Zone',
              isSelected: isAudio,
              onTap: () => onTabChanged(true),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem({
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
          // decoration: BoxDecoration(
          //   color: isSelected ? AppColors.hangoutModeDark : Colors.transparent,
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.hangoutModeDark : AppColors.black,
                size: 24,
              ),
              const SizedBox(height: 4),
              CustomText(
                text: label,
                fontSize: 12,
                fontWeight: FontWeightType.medium,
                color: isSelected ? AppColors.hangoutModeDark : AppColors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

