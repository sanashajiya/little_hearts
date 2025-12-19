import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/utils/app_mediaquery.dart';

class BottomSheetPhone extends StatelessWidget {
  final String phoneNumber;
  final bool termsAccepted;
  final ValueChanged<String> onPhoneChanged;
  final VoidCallback onGetOtp;
  final ValueChanged<bool?> onTermsChanged;

  const BottomSheetPhone({
    super.key,
    required this.phoneNumber,
    required this.termsAccepted,
    required this.onPhoneChanged,
    required this.onGetOtp,
    required this.onTermsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomText(
            text: 'Enter Mobile  Number',
            fontSize: 16,
            fontWeight: FontWeightType.regular,
            color: AppColors.textPrimary,
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderLight),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.textSecondary.withOpacity(0.12),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      bottomLeft: Radius.circular(12),
                    ),
                    border: Border(
                      right: BorderSide(color: AppColors.borderLight),
                    ),
                  ),
                  child: const CustomText(
                    text: '+91',
                    fontSize: 16,
                    fontWeight: FontWeightType.medium,
                    color: AppColors.textPrimary,
                  ),
                ),
                Expanded(
                  child: TextField(
                    onChanged: onPhoneChanged,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: InputDecoration(
                      // hintText: '79811 26542',
                      hintStyle: GoogleFonts.nunito(
                        fontSize: getProportionateScreenHeight(16),
                        color: AppColors.textHint,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                    ),
                    style: GoogleFonts.nunito(
                      fontSize: getProportionateScreenHeight(16),
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const CustomText(
            text: 'You will receive an OTP on this number',
            fontSize: 12,
            fontWeight: FontWeightType.medium,
            color: AppColors.black,
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: phoneNumber.length >= 10 ? onGetOtp : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimary,
                  disabledBackgroundColor: AppColors.buttonDisabled,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  elevation: 0,
                ),
                child: const CustomText(
                  text: 'Get OTP',
                  fontSize: 18,
                  fontWeight: FontWeightType.medium,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 12,
                  height: 12,
                  child: Transform.scale(
                    scale: 0.8,
                    child: Checkbox(
                      value: termsAccepted,
                      onChanged: onTermsChanged,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      side: const BorderSide(color: AppColors.textLink),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.nunito(
                      fontSize: getProportionateScreenHeight(9),
                    ),
                    children: [
                      TextSpan(
                        text:
                            'When I click get OTP accept Terms & Conditions of little hearts',
                        style: GoogleFonts.nunito(
                          fontSize: getProportionateScreenHeight(9),
                          color: AppColors.textLink,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
