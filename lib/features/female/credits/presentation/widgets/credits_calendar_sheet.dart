import 'package:flutter/material.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';

class CreditsCalendarSheet extends StatelessWidget {
  final DateTime month;
  final DateTime? selectedDate;
  final Set<DateTime> highlightedDates;
  final ValueChanged<DateTime> onDateSelected;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;

  const CreditsCalendarSheet({
    super.key,
    required this.month,
    required this.selectedDate,
    required this.highlightedDates,
    required this.onDateSelected,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final firstWeekday = firstDayOfMonth.weekday; // 1=Mon ... 7=Sun
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    final List<Widget> dayTiles = [];
    // Leading empty cells
    for (int i = 1; i < firstWeekday; i++) {
      dayTiles.add(const SizedBox.shrink());
    }
    // Dates
    for (int day = 1; day <= daysInMonth; day++) {
      final date = DateTime(month.year, month.month, day);
      final bool isSelected =
          selectedDate != null &&
          selectedDate!.year == date.year &&
          selectedDate!.month == date.month &&
          selectedDate!.day == date.day;

      final bool hasCall = highlightedDates.any(
        (d) =>
            d.year == date.year && d.month == date.month && d.day == date.day,
      );

      dayTiles.add(_buildDayTile(context, date, isSelected, hasCall));
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onPreviousMonth,
                icon: const Icon(Icons.chevron_left),
              ),
              CustomText(
                text: '${_monthName(month.month)} ${month.year}',
                fontSize: 16,
                fontWeight: FontWeightType.bold,
                color: AppColors.textPrimary,
              ),
              IconButton(
                onPressed: onNextMonth,
                icon: const Icon(Icons.chevron_right),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomText(
                text: 'Sun',
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              CustomText(
                text: 'Mon',
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              CustomText(
                text: 'Tue',
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              CustomText(
                text: 'Wed',
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              CustomText(
                text: 'Thu',
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              CustomText(
                text: 'Fri',
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
              CustomText(
                text: 'Sat',
                fontSize: 12,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 8),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            mainAxisSpacing: 8,
            crossAxisSpacing: 4,
            physics: const NeverScrollableScrollPhysics(),
            children: dayTiles,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const CustomText(
                  text: 'Cancel',
                  fontSize: 14,
                  fontWeight: FontWeightType.medium,
                  color: AppColors.textSecondary,
                ),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const CustomText(
                  text: 'Ok',
                  fontSize: 14,
                  fontWeight: FontWeightType.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayTile(
    BuildContext context,
    DateTime date,
    bool isSelected,
    bool hasCall,
  ) {
    return GestureDetector(
      onTap: () => onDateSelected(date),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFF2F7DFF) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: CustomText(
              text: date.day.toString(),
              fontSize: 12,
              fontWeight: isSelected
                  ? FontWeightType.bold
                  : FontWeightType.medium,
              color: isSelected ? Colors.white : AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          if (hasCall)
            Container(
              width: 4,
              height: 4,
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  String _monthName(int month) {
    const names = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return names[month - 1];
  }
}



