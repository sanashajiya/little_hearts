import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';

class ViewProfileHeader extends StatelessWidget {
  const ViewProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.white,
              size: 20,
            ),
            onPressed: () => context.pop(),
          ),
          const Spacer(),
          // No menu icon for viewing someone else's profile
        ],
      ),
    );
  }
}



