import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/custom_text.dart';

class LanguageSelectionWidget extends StatelessWidget {
  final List<String> selectedLanguages;
  final Function(String) onLanguageSelected;
  final Function(String) onLanguageDeselected;

  const LanguageSelectionWidget({
    super.key,
    required this.selectedLanguages,
    required this.onLanguageSelected,
    required this.onLanguageDeselected,
  });

  final List<Map<String, String>> languages = const [
    {'name': 'Telugu', 'script': 'తెలుగు', 'icon': '🏞️'},
    {'name': 'Kannada', 'script': 'ಕನ್ನಡ', 'icon': '🏛️'},
    {'name': 'Hindi', 'script': 'हिन्द', 'icon': '🏯'},
    {'name': 'English', 'script': 'ఇంగ్లీష్', 'icon': '🗽'},
    {'name': 'Tamil', 'script': 'தமிழ்', 'icon': '🏰'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'Languages You Speak',
          fontSize: 20,
          fontWeight: FontWeightType.semiBold,
          color: AppColors.primary,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const CustomText(
          text:
              'Connect with Friends Who Speak Your Language\nyou can select up to 2 languages',
          fontSize: 14,
          fontWeight: FontWeightType.regular,
          color: AppColors.textSecondary,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: languages.length,
          itemBuilder: (context, index) {
            final language = languages[index];
            final isSelected = selectedLanguages.contains(language['name']);
            final isDisabled = !isSelected && selectedLanguages.length >= 2;

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildLanguageTile(
                name: language['name']!,
                script: language['script']!,
                icon: language['icon']!,
                isSelected: isSelected,
                isDisabled: isDisabled,
                onTap: () {
                  if (isSelected) {
                    onLanguageDeselected(language['name']!);
                  } else if (!isDisabled) {
                    onLanguageSelected(language['name']!);
                  }
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildLanguageTile({
    required String name,
    required String script,
    required String icon,
    required bool isSelected,
    required bool isDisabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 8,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name,
                    fontSize: 16,
                    fontWeight: FontWeightType.semiBold,
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: script,
                    fontSize: 12,
                    fontWeight: FontWeightType.regular,
                    color: isSelected
                        ? Colors.white.withOpacity(0.8)
                        : AppColors.textSecondary,
                  ),
                ],
              ),
            ),
            if (isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppColors.primary,
                  size: 16,
                ),
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isDisabled ? AppColors.buttonDisabled : Colors.white,
                  border: Border.all(color: AppColors.borderLight, width: 2),
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
