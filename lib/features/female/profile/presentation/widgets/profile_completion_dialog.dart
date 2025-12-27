import 'package:flutter/material.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/widgets/custom_button.dart';

/// Profile Completion Success Dialog
class ProfileCompletionDialog extends StatelessWidget {
  final VoidCallback onContinue;

  const ProfileCompletionDialog({
    super.key,
    required this.onContinue,
  });

  static void show(BuildContext context, {required VoidCallback onContinue}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) => ProfileCompletionDialog(onContinue: onContinue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Dialog(
        
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              const CustomText(
                text: 'Awesome!',
                fontSize: 28,
                fontWeight: FontWeightType.bold,
                color: AppColors.primary,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
      
              // Description
              SizedBox(
                width: double.infinity,
                child: const CustomText(
                  text:
                      'Your profile is complete. Meet new people and start voice/video calls instantly.',
                  fontSize: 16,
                
                  fontWeight: FontWeightType.regular,
                  color: AppColors.textPrimary,
                  textAlign: TextAlign.center,
                  maxLines: null,
                  overflow: TextOverflow.visible,
                             ),
              ),
              const SizedBox(height: 24),
      
              // Continue Button with gradient
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomButton(
                  text: 'Continue',
                  onPressed: () {
                    Navigator.of(context).pop();
                    onContinue();
                  },
                  width: double.infinity,
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primaryDark,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



