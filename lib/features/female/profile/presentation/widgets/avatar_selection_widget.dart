import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/constants/custom_text.dart';

class AvatarSelectionWidget extends StatelessWidget {
  final String gender;
  final String? selectedAvatar;
  final Function(String) onAvatarSelected;

  const AvatarSelectionWidget({
    super.key,
    required this.gender,
    required this.selectedAvatar,
    required this.onAvatarSelected,
  });

  List<String> get _avatars {
    return gender == 'female'
        ? [
            'assets/images/female2.png',
            'assets/images/female1.png',
            'assets/images/female3.png',
          ]
        : [
            'assets/images/male1.png',
            'assets/images/male2.png',
            'assets/images/male3.png',
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Title
        Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CustomText(
                text: '* ',
                fontSize: 14,
                fontWeight: FontWeightType.semiBold,
                color: Colors.red,
              ),
              CustomText(
                text: 'Select Avatar',
                fontSize: 16,
                fontWeight: FontWeightType.semiBold,
                color: AppColors.textPrimary,
              ),
            ],
          ),
        ),

        const SizedBox(height: 8),

        // Avatar list (SCROLLABLE – NO OVERFLOW)
        SizedBox(
          height: 200,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: _avatars.map((avatar) {
                final bool isSelected = selectedAvatar == avatar;

                return GestureDetector(
                  onTap: () => onAvatarSelected(avatar),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    width: isSelected ? 160 : 100,
                    height: isSelected ? 160 : 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        if (isSelected)
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}


