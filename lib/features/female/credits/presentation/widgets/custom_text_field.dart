import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final String? errorText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool obscureText;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.errorText,
    this.keyboardType,
    this.onChanged,
    this.inputFormatters,
    this.maxLength,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null) ...[
            CustomText(
              text: label!,
              fontSize: 14,
              fontWeight: FontWeightType.medium,
              color: AppColors.textPrimary,
            ),
            const SizedBox(height: 8),
          ],
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            maxLength: maxLength,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(
                color: AppColors.textHint,
                fontSize: 14,
              ),
              errorText: errorText,
              filled: true,
              fillColor: AppColors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: errorText != null ? AppColors.error : AppColors.borderLight,
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: errorText != null ? AppColors.error : AppColors.borderLight,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.error,
                  width: 1,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


