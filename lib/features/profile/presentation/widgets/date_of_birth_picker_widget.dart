import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/custom_text.dart';

class DateOfBirthPickerWidget extends StatelessWidget {
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DateOfBirthPickerWidget({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(
          text: 'When is your Birth Day?',
          fontSize: 20,
          fontWeight: FontWeightType.semiBold,
          color: AppColors.primary,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        const CustomText(
          text: 'Select your birth year to complete your profile.',
          fontSize: 14,
          fontWeight: FontWeightType.regular,
          color: AppColors.textSecondary,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        _buildDatePicker(context),
      ],
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNumberPicker(
            label: 'Day',
            currentValue: selectedDate?.day ?? 26,
            minValue: 1,
            maxValue: 31,
            onChanged: (day) {
              final currentDate = selectedDate ?? DateTime.now();
              onDateSelected(
                DateTime(currentDate.year, currentDate.month, day),
              );
            },
          ),
          const SizedBox(width: 16),
          _buildNumberPicker(
            label: 'Month',
            currentValue: selectedDate?.month ?? 3,
            minValue: 1,
            maxValue: 12,
            onChanged: (month) {
              final currentDate = selectedDate ?? DateTime.now();
              onDateSelected(
                DateTime(currentDate.year, month, currentDate.day),
              );
            },
          ),
          const SizedBox(width: 16),
          _buildNumberPicker(
            label: 'Year',
            currentValue: selectedDate?.year ?? 1992,
            minValue: 1950,
            maxValue: DateTime.now().year - 13,
            onChanged: (year) {
              final currentDate = selectedDate ?? DateTime.now();
              onDateSelected(
                DateTime(year, currentDate.month, currentDate.day),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNumberPicker({
    required String label,
    required int currentValue,
    required int minValue,
    required int maxValue,
    required Function(int) onChanged,
  }) {
    return Column(
      children: [
        CustomText(
          text: label,
          fontSize: 12,
          fontWeight: FontWeightType.regular,
          color: AppColors.textSecondary,
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderLight),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListWheelScrollView(
            itemExtent: 40,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: onChanged,
            children: List.generate(maxValue - minValue + 1, (index) {
              final value = minValue + index;
              return Center(
                child: CustomText(
                  text: value.toString().padLeft(2, '0'),
                  fontSize: currentValue == value ? 18 : 14,
                  fontWeight: currentValue == value
                      ? FontWeightType.bold
                      : FontWeightType.regular,
                  color: currentValue == value
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
