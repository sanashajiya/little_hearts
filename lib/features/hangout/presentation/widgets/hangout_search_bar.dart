import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

/// Hangout Search Bar Widget
class HangoutSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const HangoutSearchBar({super.key, this.onChanged});

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
            const Icon(Icons.search, color: AppColors.hangoutMode, size: 24),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                onChanged: onChanged,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  hintText: 'Search Names',
                  hintStyle: TextStyle(
                    fontSize: 11,
                    color: AppColors.hangoutMode,
                  ),
                ),
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

