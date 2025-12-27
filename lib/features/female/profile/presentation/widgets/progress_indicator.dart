import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';

class StepProgressIndicator extends StatelessWidget {
  final int totalSteps;
  final int currentStep;

  const StepProgressIndicator({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(totalSteps, (index) {
        final bool isActive = index < currentStep;

        return Expanded(
          flex: isActive ? 3 : 2, 
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            height: 6,
            decoration: BoxDecoration(
              color: isActive
                  ? AppColors.primary
                  : AppColors.greyLight,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}


