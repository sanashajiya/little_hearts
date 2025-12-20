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

  // ✅ Updated: icon replaced with asset path
  final List<Map<String, String>> languages = const [
    {
      'name': 'Telugu',
      'script': 'తెలుగు',
      'asset': 'assets/images/telugu.png',
    },
    {
      'name': 'Kannada',
      'script': 'ಕನ್ನಡ',
      'asset': 'assets/images/kannada.png',
    },
    {
      'name': 'Hindi',
      'script': 'हिन्दी',
      'asset': 'assets/images/hindi.png',
    },
    {
      'name': 'English',
      'script': 'English',
      'asset': 'assets/images/english.png',
    },
    {
      'name': 'Tamil',
      'script': 'தமிழ்',
      'asset': 'assets/images/tamil.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
            assetPath: language['asset']!,
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
    );
  }

  Widget _buildLanguageTile({
    required String name,
    required String script,
    required String assetPath,
    required bool isSelected,
    required bool isDisabled,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.borderLight,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // ✅ Circular image container
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.greyLight,
              ),
              child: ClipOval(

                child: Image.asset(
                  assetPath,
                  fit: BoxFit.cover,
                   width: 50,
      height: 50,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Language name and script
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: name,
                    fontSize: 16,
                    fontWeight: FontWeightType.semiBold,
                    color: AppColors.textPrimary,
                  ),
                  const SizedBox(height: 4),
                  CustomText(
                    text: script,
                    fontSize: 14,
                    fontWeight: FontWeightType.regular,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
