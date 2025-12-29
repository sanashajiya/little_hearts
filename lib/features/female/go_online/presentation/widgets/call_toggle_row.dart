import 'package:flutter/material.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class CallToggleRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isEnabled;
  final ValueChanged<bool> onChanged;
  final Color? activeColor;

  const CallToggleRow({
    super.key,
    required this.icon,
    required this.label,
    required this.isEnabled,
    required this.onChanged,
    this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    final toggleColor = activeColor ?? AppColors.dateMode;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(

            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.greyLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Colors.red,
              size: 32,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: CustomText(
              text: label,
              fontSize: 16,
              fontWeight: FontWeightType.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: onChanged,
            activeColor: toggleColor,
            activeTrackColor: toggleColor.withOpacity(0.5),
            inactiveThumbColor: Colors.white,
            // inactiveTrackColor: AppColors.greyLight,
          ),
        ],
      ),
    );
  }
}



