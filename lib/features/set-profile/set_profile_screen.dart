import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/custom_text.dart';
import '../../core/theme/app_colors.dart';
import '../male/profile/presentation/bloc/profile_setup_bloc.dart';
import '../male/profile/presentation/bloc/profile_setup_event.dart';
import '../male/profile/presentation/bloc/profile_setup_state.dart';
import '../male/profile/presentation/widgets/avatar_selection_widget.dart';
import '../male/profile/presentation/widgets/gender_selection_widget.dart';
import '../male/profile/presentation/widgets/progress_indicator.dart' as pi;

class SetProfileScreen extends StatefulWidget {
  final VoidCallback onContinue;

  const SetProfileScreen({super.key, required this.onContinue});

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  late TextEditingController _nameController;
  String? _usernameError;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _validateUsername(String value) {
    context.read<ProfileSetupBloc>().add(NameChanged(value));

    setState(() {
      if (value.isEmpty) {
        _usernameError = 'Username is required';
      } else if (value.length < 3) {
        _usernameError = 'Min 3 characters';
      } else if (value.length > 20) {
        _usernameError = 'Max 20 characters';
      } else {
        _usernameError = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileSetupBloc, ProfileSetupState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progress Indicator
                Row(
                  children: [
                    // Back arrow
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //   },
                    //   icon: const Icon(
                    //     Icons.arrow_back_ios_new,
                    //     size: 18,
                    //     color: AppColors.black,
                    //   ),
                    // ),

                    const SizedBox(width: 8),

                    // Progress indicator
                    Expanded(
                      child: pi.StepProgressIndicator(
                        totalSteps: 3,
                        currentStep: 1,
                      ),
                    ),
                  ],
                ),

                // const SizedBox(height: 8),

                // Title
                Center(
                  child: const CustomText(
                    text: 'Set Profile',
                    fontSize: 28,
                    fontWeight: FontWeightType.bold,
                    color: AppColors.primary,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 12),

                // Subtitle
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: CustomText(
                        text: '* ',
                        fontSize: 14,
                        fontWeight: FontWeightType.semiBold,
                        color: Colors.red,
                      ),
                    ),
                    CustomText(
                      text: 'Enter User Name',
                      fontSize: 14,
                      fontWeight: FontWeightType.regular,
                      color: AppColors.black,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Username Input Field
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _nameController,
                    onChanged: _validateUsername,
                    decoration: InputDecoration(
                      hintText: 'Min 3 - Max 20 Characters',
                      hintStyle: const TextStyle(
                        color: AppColors.textHint,
                        fontSize: 12,
                      ),
                      filled: true,
                      fillColor: AppColors.greyLight,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: _usernameError != null
                              ? AppColors.error
                              : AppColors.borderLight,
                          width: 2,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: _usernameError != null
                              ? AppColors.error
                              : AppColors.borderLight,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColors.primary,
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      suffixText: '${_nameController.text.length}/20',
                      suffixStyle: const TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Error message
                if (_usernameError != null)
                  CustomText(
                    text: _usernameError!,
                    fontSize: 12,
                    fontWeight: FontWeightType.regular,
                    color: AppColors.error,
                  )
                else
                  // const CustomText(
                  //   text: 'Min 3 - Max 20 Characters',
                  //   fontSize: 12,
                  //   fontWeight: FontWeightType.regular,
                  //   color: AppColors.textSecondary,
                  // ),
                  const SizedBox(height: 8),
                // Avatar Selection - Only show if gender is selected
                if (state.genderSelected)
                  AvatarSelectionWidget(
                    gender: state.gender!,
                    selectedAvatar: state.selectedAvatar,
                    onAvatarSelected: (avatar) {
                      context.read<ProfileSetupBloc>().add(
                        AvatarSelected(avatar),
                      );
                    },
                  ),
                const SizedBox(height: 32),

                // Gender Selection
                GenderSelectionWidget(
                  selectedGender: state.gender,
                  onGenderSelected: (gender) {
                    context.read<ProfileSetupBloc>().add(
                      GenderSelected(gender),
                    );
                  },
                ),
                const SizedBox(height: 12),

                // Continue Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: state.canProgressFromScreen1
                          ? widget.onContinue
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.canProgressFromScreen1
                            ? AppColors.primary
                            : AppColors.buttonDisabled,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: state.canProgressFromScreen1 ? 4 : 0,
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
