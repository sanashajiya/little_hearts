import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class ExploreSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const ExploreSearchBar({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.friendModeDark, size: 30),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: 'Search Names',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: AppColors.friendModeDark,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.friendModeDark,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
