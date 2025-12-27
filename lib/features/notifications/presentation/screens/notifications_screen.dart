import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/repositories/notification_repository.dart';
import '../../domain/entities/notification.dart' as entities;
import '../widgets/notifications_app_bar.dart';
import '../widgets/notification_item.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final NotificationRepository _repository = NotificationRepositoryImpl();
  List<entities.Notification> _notifications = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    setState(() {
      _isLoading = true;
    });

    final notifications = await _repository.getNotifications();

    setState(() {
      _notifications = notifications;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greyLight,
      appBar: const NotificationsAppBar(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            )
          : _notifications.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.notifications_none,
                        size: 64,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'No notifications yet',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                  margin: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: ListView.separated(
                    itemCount: _notifications.length,
                    separatorBuilder: (context, index) => Divider(
                      height: 1,
                      thickness: 1,
                      color: AppColors.borderLight,
                    ),
                    itemBuilder: (context, index) {
                      return NotificationItem(
                        notification: _notifications[index],
                      );
                    },
                  ),
                ),
    );
  }
}

