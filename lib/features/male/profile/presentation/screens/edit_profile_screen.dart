import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../cubit/edit_profile_cubit.dart';
import '../widgets/profile_image_picker.dart';
import '../widgets/edit_profile_form.dart';
import '../widgets/save_changes_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditProfileCubit(),
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatelessWidget {
  const _EditProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.textPrimary,
            size: 20,
          ),
          onPressed: () => context.pop(),
        ),
        title: const CustomText(
          text: 'Edit Profile',
          fontSize: 18,
          fontWeight: FontWeightType.bold,
          color: AppColors.textPrimary,
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<EditProfileCubit, EditProfileState>(
        builder: (context, state) {
          if (state is EditProfileLoaded) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const ProfileImagePicker(),
                  const SizedBox(height: 24),
                  EditProfileForm(
                    name: state.name,
                    dateOfBirth: state.dateOfBirth,
                    country: state.country,
                    age: state.age,
                    about: state.about,
                  ),
                  const SizedBox(height: 32),
                  const SaveChangesButton(),
                  const SizedBox(height: 24),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

