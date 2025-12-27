import '../../domain/entities/notification.dart';
import '../../domain/entities/notification_type.dart';

abstract class NotificationRepository {
  Future<List<Notification>> getNotifications();
}

class NotificationRepositoryImpl implements NotificationRepository {
  @override
  Future<List<Notification>> getNotifications() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    final now = DateTime.now();

    return [
      Notification(
        id: '1',
        type: NotificationType.like,
        title: 'You got a Like!',
        subtitle: 'Sarah liked your profile.',
        timestamp: now.subtract(const Duration(minutes: 2)),
        isRead: false,
      ),
      Notification(
        id: '2',
        type: NotificationType.message,
        title: 'You got a Message',
        subtitle: 'Alexa sent you a message.',
        timestamp: DateTime(
          now.year,
          now.month,
          now.day - 1,
          9,
          56,
        ),
        isRead: false,
      ),
      Notification(
        id: '3',
        type: NotificationType.virtualGift,
        title: 'Virtual Gift',
        subtitle: 'Emma sent you a virtual rose.',
        timestamp: DateTime(
          now.year,
          now.month,
          now.day - 15,
          9,
          56,
        ),
        isRead: true,
      ),
      Notification(
        id: '4',
        type: NotificationType.superLike,
        title: 'Super Like!',
        subtitle: 'Maya super liked your profile.',
        timestamp: DateTime(
          now.year,
          now.month,
          now.day - 15,
          9,
          56,
        ),
        isRead: true,
      ),
      Notification(
        id: '5',
        type: NotificationType.profileView,
        title: 'Profile View',
        subtitle: 'Aaradya viewed your profile.',
        timestamp: DateTime(
          now.year,
          now.month,
          now.day - 30,
          9,
          56,
        ),
        isRead: true,
      ),
    ];
  }
}

