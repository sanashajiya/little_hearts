import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/utils/app_mediaquery.dart';

class BottomSheetInitial extends StatelessWidget {
  final bool termsAccepted;
  final VoidCallback onLetsGo;
  final ValueChanged<bool?> onTermsChanged;

  const BottomSheetInitial({
    super.key,
    required this.termsAccepted,
    required this.onLetsGo,
    required this.onTermsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              text: 'No chats, no waiting. Real-time voice\nconnections',
              fontSize: 16,
              fontWeight: FontWeightType.medium,
              color: AppColors.textPrimary,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onLetsGo,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 0,
                  ),
                  child: const CustomText(
                    text: "Let's Go",
                    fontSize: 16,
                    fontWeight: FontWeightType.semiBold,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            // const SizedBox(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       width: 12,
            //       height: 12,
            //       child: Checkbox(
            //         value: termsAccepted,
            //         onChanged: onTermsChanged,
            //         shape: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(4),
            //         ),
            //         side: const BorderSide(color: AppColors.textLink),
            //       ),
            //     ),
            //     const SizedBox(width: 10),
            //     RichText(
            //       text: TextSpan(
            //         style: GoogleFonts.nunito(
            //           fontSize: getProportionateScreenHeight(12),
            //         ),
            //         children: [
            //           TextSpan(
            //             text: 'When I click get OTP accept Terms & Conditions\n of little hearts',
            //             style: GoogleFonts.nunito(
            //               fontSize: getProportionateScreenHeight(12),
            //               color: AppColors.textLink,
            //               decoration: TextDecoration.underline,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
