import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/edit_profile_cubit.dart';

class EditProfileForm extends StatelessWidget {
  final String name;
  final String dateOfBirth;
  final String country;
  final int age;
  final String about;

  const EditProfileForm({
    super.key,
    required this.name,
    required this.dateOfBirth,
    required this.country,
    required this.age,
    required this.about,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField(
          label: 'Name',
          value: name,
          onChanged: (value) {
            context.read<EditProfileCubit>().updateName(value);
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Date of Birth',
          value: dateOfBirth,
          onChanged: (value) {
            context.read<EditProfileCubit>().updateDateOfBirth(value);
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Country / Region',
          value: country,
          onChanged: (value) {
            context.read<EditProfileCubit>().updateCountry(value);
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'Age',
          value: age.toString(),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            final ageValue = int.tryParse(value);
            if (ageValue != null) {
              context.read<EditProfileCubit>().updateAge(ageValue);
            }
          },
        ),
        const SizedBox(height: 16),
        _buildTextField(
          label: 'About',
          value: about,
          maxLines: 5,
          onChanged: (value) {
            context.read<EditProfileCubit>().updateAbout(value);
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: label,
          fontSize: 14,
          fontWeight: FontWeightType.medium,
          color: AppColors.textPrimary,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value)
            ..selection = TextSelection.collapsed(offset: value.length),
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.borderLight,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.borderLight,
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
            fillColor: AppColors.white,
            filled: true,
          ),
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.textPrimary,
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

