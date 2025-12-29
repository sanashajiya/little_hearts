import 'notification_type.dart';

class Notification {
  final String id;
  final NotificationType type;
  final String title;
  final String subtitle;
  final DateTime timestamp;
  final bool isRead;

  const Notification({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    this.isRead = false,
  });
}


