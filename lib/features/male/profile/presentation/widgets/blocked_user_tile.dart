import 'package:flutter/material.dart';

import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import 'unblock_button.dart';

class BlockedUserTile extends StatelessWidget {
  final String name;
  final String avatar;
  final VoidCallback onUnblock;

  const BlockedUserTile({
    super.key,
    required this.name,
    required this.avatar,
    required this.onUnblock,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.borderLight,
                width: 1,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                avatar,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/profile.png',
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomText(
              text: name,
              fontSize: 16,
              fontWeight: FontWeightType.medium,
              color: AppColors.textPrimary,
            ),
          ),
          UnblockButton(onTap: onUnblock),
        ],
      ),
    );
  }
}

