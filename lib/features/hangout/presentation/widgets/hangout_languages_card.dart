import 'package:flutter/material.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class HangoutLanguagesCard extends StatelessWidget {
  final List<String> languages;

  const HangoutLanguagesCard({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Languages',
            fontSize: 18,
            fontWeight: FontWeightType.bold,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12, // horizontal space between chips
            runSpacing: 12, // vertical space between lines
            alignment: WrapAlignment.start,
            children: languages.map((language) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.hangoutMode,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomText(
                  text: language,
                  fontSize: 14,
                  fontWeight: FontWeightType.medium,
                  color: AppColors.white,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
