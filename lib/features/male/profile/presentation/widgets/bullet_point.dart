import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 6, right: 8),
          child: Icon(
            Icons.circle,
            size: 6,
            color: AppColors.backgroundDark,
          ),
        ),
        Expanded(
          child: CustomText(
            text: text,
            fontSize: 14,
            fontWeight: FontWeightType.regular,
            color: AppColors.textPrimary,
            maxLines: null,
            overflow: TextOverflow.visible,
          ),
        ),
      ],
    );
  }
}

