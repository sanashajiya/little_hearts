import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/constants/custom_text.dart';

class GenderSelectionWidget extends StatelessWidget {
  final String? selectedGender;
  final Function(String) onGenderSelected;

  const GenderSelectionWidget({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
  child: Row(
    mainAxisSize: MainAxisSize.min,
    children: const [
      CustomText(
        text: '* ',
        fontSize: 16,
        fontWeight: FontWeightType.semiBold,
        color: Colors.red,
      ),
      CustomText(
        text: "What's Your Gender?",
        fontSize: 16,
        fontWeight: FontWeightType.semiBold,
        color: AppColors.textPrimary,
      ),
    ],
  ),
),



        const SizedBox(height: 20),

        // Gender cards
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildGenderOption(
              label: 'Female',
              imagePath: 'assets/images/female4.png',
              isSelected: selectedGender == 'female',
              onTap: () => onGenderSelected('female'),
            ),
            const SizedBox(width: 16),
            _buildGenderOption(
              label: 'Male',
              imagePath: 'assets/images/male2.png',
              isSelected: selectedGender == 'male',
              onTap: () => onGenderSelected('male'),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Warning text
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 16),
              child: Icon(Icons.error_outline, size: 14, color: AppColors.error),
            ),
            SizedBox(width: 6),
            CustomText(
              text: "Gender can't be changed later",
              fontSize: 12,
              color: AppColors.error,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption({
    required String label,
    required String imagePath,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120, // 
        height: 130, // 
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : const Color(0xFFE6E6E6),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Label
            CustomText(
              text: label,
              fontSize: 14,
              fontWeight: FontWeightType.medium,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}



