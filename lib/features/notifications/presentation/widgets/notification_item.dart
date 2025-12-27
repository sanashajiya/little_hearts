import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/notification.dart' as entities;
import 'notification_icon.dart';
import 'notification_time.dart';

class NotificationItem extends StatelessWidget {
  final entities.Notification notification;

  const NotificationItem({
    super.key,
    required this.notification,
  });

  Color _getBackgroundColor() {
    final now = DateTime.now();
    final difference = now.difference(notification.timestamp);

    // Unread or recent (less than 1 day old) → light purple/pink tint
    if (!notification.isRead || difference.inDays < 1) {
      // return AppColors.dateModeLight.withOpacity(0.2);
    }

    // Older notifications → white background
    return AppColors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _getBackgroundColor(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Section - Icon
          NotificationIcon(
            type: notification.type,
            size: 48,
          ),
          const SizedBox(width: 12),
          // Middle Section - Text
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: notification.title,
                  fontSize: 14,
                  fontWeight: FontWeightType.bold,
                  color: AppColors.textPrimary,
                ),
                const SizedBox(height: 4),
                CustomText(
                  text: notification.subtitle,
                  fontSize: 13,
                  fontWeight: FontWeightType.regular,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Right Section - Time
          NotificationTime(timestamp: notification.timestamp),
        ],
      ),
    );
  }
}

