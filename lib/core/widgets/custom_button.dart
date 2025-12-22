import 'package:flutter/material.dart';
import '../constants/custom_text.dart';
import '../theme/app_colors.dart';

/// Reusable Custom Button Widget
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderRadius;
  final FontWeightType? fontWeight;
  final double? fontSize;
  final Gradient? gradient;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.fontWeight,
    this.fontSize,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasGradient = gradient != null;
    final Color? bgColor = hasGradient ? null : (backgroundColor ?? AppColors.primary);

    if (hasGradient) {
      // Use Container with InkWell for gradient support
      return Container(
        width: width ?? double.infinity,
        height: height ?? 52,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: onPressed != null
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Center(
              child: CustomText(
                text: text,
                fontSize: fontSize ?? 16,
                fontWeight: fontWeight ?? FontWeightType.bold,
                color: textColor ?? Colors.white,
              ),
            ),
          ),
        ),
      );
    }

    // Use ElevatedButton for solid colors
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 52,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          disabledBackgroundColor: AppColors.buttonDisabled,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          elevation: onPressed != null ? 4 : 0,
        ),
        child: CustomText(
          text: text,
          fontSize: fontSize ?? 16,
          fontWeight: fontWeight ?? FontWeightType.bold,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }
}

