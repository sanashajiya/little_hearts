import 'package:flutter/material.dart';
import '../../domain/entities/notification_type.dart';

class NotificationIcon extends StatelessWidget {
  final NotificationType type;
  final double size;

  const NotificationIcon({
    super.key,
    required this.type,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color backgroundColor;

    switch (type) {
      case NotificationType.like:
        iconData = Icons.local_fire_department;
        backgroundColor = Colors.orange;
        break;
      case NotificationType.message:
        iconData = Icons.chat_bubble;
        backgroundColor = Colors.green;
        break;
      case NotificationType.virtualGift:
        iconData = Icons.card_giftcard;
        backgroundColor = Colors.red;
        break;
      case NotificationType.superLike:
        iconData = Icons.favorite;
        backgroundColor = Colors.red.shade900;
        break;
      case NotificationType.profileView:
        iconData = Icons.visibility;
        backgroundColor = Colors.blue;
        break;
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: Colors.white,
        size: size * 0.5,
      ),
    );
  }
}


