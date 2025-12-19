import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/custom_text.dart';

class TermsDialog extends StatelessWidget {
  final VoidCallback onAccept;

  const TermsDialog({super.key, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomText(
              text: 'Welcome to Little Hearts!',
              fontSize: 20,
              fontWeight: FontWeightType.bold,
              color: AppColors.textPrimary,
            ),
            const SizedBox(height: 12),
            const CustomText(
              text: 'Little Hearts – Terms & Conditions',
              fontSize: 17,
              fontWeight: FontWeightType.semiBold,
              color: AppColors.textPrimary,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 12),
            const CustomText(
              text:
                  'By accessing or using the Little Hearts mobile application, you agree to comply with and be legally bound by these Terms & Conditions.These Terms govern your use of all features, services, and content provided by the App.',
              fontSize: 12,
              color: AppColors.textPrimary,
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 16),
            const CustomText(
              text: 'Eligibility:',
              fontSize: 16,
              fontWeight: FontWeightType.semiBold,
              color: AppColors.textPrimary,
            ),
            const SizedBox(height: 8),
            _buildBulletPoint('You must be 18+ to use Little Hearts.'),
            _buildBulletPoint('Use your real information — no fake profiles.'),
            _buildBulletPoint('Have a valid phone number or email.'),
            _buildBulletPoint('You must not have any previous banned account.'),
            _buildBulletPoint('Follow our community rules and local laws.'),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onAccept,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: const CustomText(
                    text: 'Accept',
                    fontSize: 18,
                    fontWeight: FontWeightType.semiBold,
                    color: AppColors.white,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(text: '• ', fontSize: 13),
          Expanded(
            child: CustomText(
              text: text,
              fontSize: 13,
              color: AppColors.textPrimary,
              maxLines: null,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}
