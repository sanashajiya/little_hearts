import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../bloc/profile_setup_bloc.dart';
import '../bloc/profile_setup_event.dart';
import '../bloc/profile_setup_state.dart';
import '../widgets/date_of_birth_picker_widget.dart';
import '../widgets/progress_indicator.dart' as pi;

class DateOfBirthScreen extends StatelessWidget {
  final VoidCallback onContinue;
  final VoidCallback onBack;

  const DateOfBirthScreen({
    super.key,
    required this.onContinue,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button and Progress
                Row(
                  children: [
                    GestureDetector(
                      onTap: onBack,
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: AppColors.primary,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: pi.StepProgressIndicator(
                        totalSteps: 3,
                        currentStep: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Title
                const Center(
                  child: CustomText(
                    text: 'When is your Birth Day?',
                    fontSize: 24,
                    fontWeight: FontWeightType.bold,
                    color: AppColors.primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                const Center(
                  child: CustomText(
                    text: 'Select your birth year to complete your profile.',
                    fontSize: 14,
                    fontWeight: FontWeightType.regular,
                    color: AppColors.black,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 32),

                // Birthday Image
                Center(
                  child: Image.asset(
                    'assets/images/birthday.png',
                    height: 220,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 32),

                // Date of Birth Picker
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: DateOfBirthPickerWidget(
                    selectedDate: state.dateOfBirth ?? DateTime(1993, 4, 27),
                    onDateSelected: (date) {
                      context.read<ProfileSetupBloc>().add(
                        DateOfBirthChanged(date),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 48),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: state.canProgressFromScreen2
                          ? onContinue
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.canProgressFromScreen2
                            ? AppColors.primary
                            : AppColors.buttonDisabled,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: state.canProgressFromScreen2 ? 4 : 0,
                      ),
                      child: const CustomText(
                        text: 'Continue',
                        fontSize: 16,
                        fontWeight: FontWeightType.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
