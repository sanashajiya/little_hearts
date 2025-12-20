import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/custom_text.dart';
import '../bloc/profile_setup_bloc.dart';
import '../bloc/profile_setup_event.dart';
import '../bloc/profile_setup_state.dart';
import '../widgets/progress_indicator.dart' as pi;
import '../widgets/language_selection_widget.dart';

class LanguagesSelectionScreen extends StatelessWidget {
  final VoidCallback onFinish;
  final VoidCallback onBack;

  const LanguagesSelectionScreen({
    super.key,
    required this.onFinish,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back Button and Progress
                Row(
                  children: [
                    GestureDetector(
                      onTap: onBack,
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: pi.StepProgressIndicator(
                        totalSteps: 3,
                        currentStep: 3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Language Selection Widget
                LanguageSelectionWidget(
                  selectedLanguages: state.selectedLanguages,
                  onLanguageSelected: (language) {
                    context.read<ProfileSetupBloc>().add(
                      LanguageSelected(language),
                    );
                  },
                  onLanguageDeselected: (language) {
                    context.read<ProfileSetupBloc>().add(
                      LanguageDeselected(language),
                    );
                  },
                ),
                const SizedBox(height: 48),

                // Finish Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: state.canFinish ? onFinish : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: state.canFinish
                          ? AppColors.primary
                          : AppColors.buttonDisabled,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: state.canFinish ? 4 : 0,
                    ),
                    child: const CustomText(
                      text: 'Finish',
                      fontSize: 16,
                      fontWeight: FontWeightType.bold,
                      color: Colors.white,
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
