import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

/// Reason Radio Tile Widget
class ReasonRadioTile extends StatelessWidget {
  final String reason;
  final bool isSelected;
  final VoidCallback onTap;

  const ReasonRadioTile({
    super.key,
    required this.reason,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Row(
          children: [
            Radio<String>(
              value: reason,
              groupValue: isSelected ? reason : null,
              onChanged: (_) => onTap(),
              activeColor: AppColors.hangoutMode,
            ),
            const SizedBox(width: 2),
            Expanded(
              child: CustomText(
                text: reason,
                fontSize: 14,
                fontWeight: FontWeightType.medium,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

