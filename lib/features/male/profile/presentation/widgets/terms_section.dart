import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import 'bullet_point.dart';

class TermsSection extends StatelessWidget {
  final String title;
  final List<String> points;

  const TermsSection({
    super.key,
    required this.title,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: title,
          fontSize: 18,
          fontWeight: FontWeightType.bold,
          color: AppColors.black,
        ),
        const SizedBox(height: 12),
        ...points.map((point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: BulletPoint(text: point,),
            )),
      ],
    );
  }
}

