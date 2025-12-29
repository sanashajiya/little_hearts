import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

/// Zone Selection Card Widget (for Create Hangout Screen)
class ZoneSelectionCard extends StatelessWidget {
  final bool isAudio;
  final bool isSelected;
  final VoidCallback onTap;

  const ZoneSelectionCard({
    super.key,
    required this.isAudio,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.hangoutModeLight : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.hangoutMode : AppColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            
            CustomText(
              text: isAudio ? 'Audio Zone' : 'Video Zone',
              fontSize: 16,
              fontWeight: FontWeightType.bold,
              color: AppColors.textPrimary,
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color:AppColors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isSelected ? AppColors.white : AppColors.grey,
                  width: 1,
                )
                
              ),
              child: Icon(
                isAudio ? Icons.mic : Icons.videocam,
                size: 32,
                color: isSelected ? Colors.red : AppColors.grey,
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}


