import 'package:flutter/material.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/theme/app_colors.dart';

/// Join Button Widget
class JoinButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const JoinButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      text: 'Join',
      backgroundColor: AppColors.hangoutMode,
      onPressed: onPressed,
      borderRadius: 12,
    );
  }
}


