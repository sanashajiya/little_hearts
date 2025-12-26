import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';

class PanUploadCard extends StatelessWidget {
  final String label;
  final String? imagePath;
  final ValueChanged<String> onImageSelected;

  const PanUploadCard({
    super.key,
    required this.label,
    this.imagePath,
    required this.onImageSelected,
  });

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && context.mounted) {
      onImageSelected(image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);
    final isUploaded = imagePath != null;

    return Expanded(
      child: GestureDetector(
        onTap: () => _pickImage(context),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isUploaded ? zoneTheme.primary : AppColors.borderLight,
              width: isUploaded ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isUploaded && imagePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(imagePath!),
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: zoneTheme.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.cloud_upload_outlined,
                    color: zoneTheme.primary,
                    size: 32,
                  ),
                ),
              const SizedBox(height: 12),
              CustomText(
                text: label,
                fontSize: 12,
                fontWeight: FontWeightType.medium,
                color: AppColors.textPrimary,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

