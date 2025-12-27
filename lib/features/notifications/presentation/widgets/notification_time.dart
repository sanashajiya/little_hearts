import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class NotificationTime extends StatelessWidget {
  final DateTime timestamp;

  const NotificationTime({
    super.key,
    required this.timestamp,
  });

  String _getTimeString(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final notificationDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min ago';
    } else if (notificationDate == today) {
      // Still today, show hours ago
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else {
      // Older than today, show time in 12-hour format
      final hour = dateTime.hour;
      final minute = dateTime.minute;
      final period = hour >= 12 ? 'PM' : 'AM';
      final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
      final displayMinute = minute.toString().padLeft(2, '0');
      return '$displayHour.$displayMinute $period';
    }
  }

  String _getDateLabel(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final notificationDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (notificationDate == today) {
      return 'Today.';
    } else if (notificationDate == yesterday) {
      return 'Yesterday.';
    } else {
      final difference = today.difference(notificationDate).inDays;
      if (difference < 30) {
        return '${difference}Days ago.';
      } else if (difference < 60) {
        return '1 month ago.';
      } else {
        final months = (difference / 30).floor();
        return '$months month${months > 1 ? 's' : ''} ago.';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomText(
          text: _getTimeString(timestamp),
          fontSize: 12,
          fontWeight: FontWeightType.medium,
          color: AppColors.textSecondary,
        ),
        const SizedBox(height: 2),
        CustomText(
          text: _getDateLabel(timestamp),
          fontSize: 11,
          fontWeight: FontWeightType.regular,
          color: AppColors.textSecondary,
        ),
      ],
    );
  }
}

