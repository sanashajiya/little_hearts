import 'package:flutter/material.dart';

import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

/// Custom scroll physics for smoother date picker scrolling
class SmoothFixedExtentScrollPhysics extends FixedExtentScrollPhysics {
  const SmoothFixedExtentScrollPhysics({super.parent});

  @override
  SmoothFixedExtentScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SmoothFixedExtentScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 0.5,
        stiffness: 100.0,
        damping: 0.8,
      );
}

class DateOfBirthPickerWidget extends StatefulWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DateOfBirthPickerWidget({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<DateOfBirthPickerWidget> createState() =>
      _DateOfBirthPickerWidgetState();
}

class _DateOfBirthPickerWidgetState extends State<DateOfBirthPickerWidget> {
  late FixedExtentScrollController _dayController;
  late FixedExtentScrollController _monthController;
  late FixedExtentScrollController _yearController;

  late int _selectedDay;
  late int _selectedMonth;
  late int _selectedYear;

  @override
  void initState() {
    super.initState();
    final initialDate = widget.selectedDate ?? DateTime(1993, 4, 27);
    _selectedDay = initialDate.day;
    _selectedMonth = initialDate.month;
    _selectedYear = initialDate.year;

    _dayController = FixedExtentScrollController(initialItem: _selectedDay - 1);
    _monthController = FixedExtentScrollController(
      initialItem: _selectedMonth - 1,
    );
    _yearController = FixedExtentScrollController(
      initialItem: _selectedYear - 1950,
    );
  }

  @override
  void didUpdateWidget(DateOfBirthPickerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate &&
        widget.selectedDate != null) {
      final date = widget.selectedDate!;
      _selectedDay = date.day;
      _selectedMonth = date.month;
      _selectedYear = date.year;
      _dayController.jumpToItem(_selectedDay - 1);
      _monthController.jumpToItem(_selectedMonth - 1);
      _yearController.jumpToItem(_selectedYear - 1950);
    }
  }

  @override
  void dispose() {
    _dayController.dispose();
    _monthController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  void _updateDate() {
    // Ensure valid date (handle edge cases like Feb 30)
    int day = _selectedDay;
    int month = _selectedMonth;
    int year = _selectedYear;

    // Get the last day of the selected month
    final lastDayOfMonth = DateTime(year, month + 1, 0).day;
    if (day > lastDayOfMonth) {
      day = lastDayOfMonth;
      if (_selectedDay != day) {
        setState(() {
          _selectedDay = day;
        });
        _dayController.jumpToItem(day - 1);
      }
    }

    final newDate = DateTime(year, month, day);
    widget.onDateSelected(newDate);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderLight,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNumberPicker(
            label: 'Day',
            controller: _dayController,
            selectedValue: _selectedDay,
            minValue: 1,
            maxValue: 31,
            onChanged: (day) {
              setState(() {
                _selectedDay = day;
                _updateDate();
              });
            },
          ),
          _buildNumberPicker(
            label: 'Month',
            controller: _monthController,
            selectedValue: _selectedMonth,
            minValue: 1,
            maxValue: 12,
            onChanged: (month) {
              setState(() {
                _selectedMonth = month;
                // Validate day for the new month
                final lastDayOfMonth = DateTime(_selectedYear, month + 1, 0).day;
                if (_selectedDay > lastDayOfMonth) {
                  _selectedDay = lastDayOfMonth;
                  _dayController.jumpToItem(_selectedDay - 1);
                }
                _updateDate();
              });
            },
          ),
          _buildNumberPicker(
            label: 'Year',
            controller: _yearController,
            selectedValue: _selectedYear,
            minValue: 1950,
            maxValue: DateTime.now().year - 13,
            onChanged: (year) {
              setState(() {
                _selectedYear = year;
                // Validate day for the new year (leap year handling)
                final lastDayOfMonth = DateTime(year, _selectedMonth + 1, 0).day;
                if (_selectedDay > lastDayOfMonth) {
                  _selectedDay = lastDayOfMonth;
                  _dayController.jumpToItem(_selectedDay - 1);
                }
                _updateDate();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNumberPicker({
    required String label,
    required FixedExtentScrollController controller,
    required int selectedValue,
    required int minValue,
    required int maxValue,
    required Function(int) onChanged,
  }) {
    final itemCount = maxValue - minValue + 1;

    return Column(
      children: [
        CustomText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeightType.regular,
          color: AppColors.textSecondary,
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: 70,
          height: 150,
          child: ListWheelScrollView.useDelegate(
            controller: controller,
            itemExtent: 50,
            physics: const SmoothFixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) {
              final value = minValue + index;
              onChanged(value);
            },
            perspective: 0.003,
            diameterRatio: 1.2,
            useMagnifier: false,
            offAxisFraction: 0.0,
            squeeze: 0.8,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: itemCount,
              builder: (context, index) {
                final value = minValue + index;
                final isSelected = value == selectedValue;
                return Center(
                  child: CustomText(
                    text: value.toString().padLeft(2, '0'),
                    fontSize: isSelected ? 24 : 16,
                    fontWeight: isSelected
                        ? FontWeightType.bold
                        : FontWeightType.regular,
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.textSecondary.withOpacity(0.5),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
