import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/constants/custom_text.dart';
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
                        currentStep: 3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Title
                const Center(
                  child: CustomText(
                    text: 'Languages You Speak',
                    fontSize: 28,
                    fontWeight: FontWeightType.bold,
                    color: AppColors.primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),

                // Description
                const Center(
                  child: CustomText(
                    text: 'Connect with Friends Who Speak Your Language',
                    fontSize: 14,
                    fontWeight: FontWeightType.regular,
                    color: AppColors.black,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 4),
                const Center(
                  child: CustomText(
                    text: 'you can select up to 2 languages',
                    fontSize: 12,
                    fontWeight: FontWeightType.regular,
                    color: AppColors.black,
                    textAlign: TextAlign.center,
                  ),
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
                const SizedBox(height: 14),

                // Finish Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
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
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
