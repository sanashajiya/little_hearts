import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class SaveChangesButton extends StatelessWidget {
  const SaveChangesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          onPressed: () {
            // TODO: Save changes logic
          },
          child: const CustomText(
            text: 'Save Changes',
            fontSize: 16,
            fontWeight: FontWeightType.bold,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}




