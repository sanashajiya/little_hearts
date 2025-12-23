import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/friend_avatar.dart';

class CircularAvatarLayout extends StatelessWidget {
  final FriendAvatar centerAvatar;
  final List<FriendAvatar> surroundingAvatars;

  const CircularAvatarLayout({
    super.key,
    required this.centerAvatar,
    required this.surroundingAvatars,
  });
  static const double _containerSize = 280;
  static const double _dottedRadius = 115; // half of container
  static const double _avatarSize = 60;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
      height: 280,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dotted circle path
          CustomPaint(
            size: const Size(280, 280),
            painter: DottedCirclePainter(),
          ),
          // Center avatar (large)
          _buildCenterAvatar(centerAvatar),
          // Surrounding avatars (5 smaller ones)
          ..._buildSurroundingAvatars(surroundingAvatars),
        ],
      ),
    );
  }

  Widget _buildCenterAvatar(FriendAvatar avatar) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // OUTER DOTTED / FAINT CIRCLE (optional, for later animation)
        Container(
          width: 220,
          height: 220,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.friendModeLight.withOpacity(0.15),
          ),
        ),

        // WHITE RING
        Container(
          width: 185,
          height: 185,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
        ),

        // BLUE INNER RING
        Container(
          width: 130,
          height: 130,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFF6EAFF1),
          ),
        ),

        // AVATAR IMAGE
        Container(
          width: 78,
          height: 78,
          decoration: const BoxDecoration(shape: BoxShape.circle),
          child: ClipOval(
            child: Image.asset(avatar.imageAsset, fit: BoxFit.cover),
          ),
        ),

        if (avatar.isOnline) _buildOnlineIndicator(),
      ],
    );
  }

  List<Widget> _buildSurroundingAvatars(List<FriendAvatar> avatars) {
    final int count = math.min(avatars.length, 5);
    final double angleStep = (2 * math.pi) / count;

    return List.generate(count, (index) {
      final double angle = -math.pi / 2 + angleStep * index;

      final double x =
          (_containerSize / 2) +
          _dottedRadius * math.cos(angle) -
          (_avatarSize / 2);

      final double y =
          (_containerSize / 2) +
          _dottedRadius * math.sin(angle) -
          (_avatarSize / 2);

      return Positioned(
        left: x,
        top: y,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: _avatarSize,
              height: _avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.friendModeLight.withOpacity(0.2),
              ),
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: Image.asset(
                  avatars[index].imageAsset,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (avatars[index].isOnline) _buildSmallOnlineIndicator(),
          ],
        ),
      );
    });
  }

  Widget _buildOnlineIndicator() {
    return Positioned(
      top: 75,
      right: 75,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      ),
    );
  }

  Widget _buildSmallOnlineIndicator() {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1.5),
        ),
      ),
    );
  }
}

class DottedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.white
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 2;

    // Draw dotted circle
    const dashWidth = 5.0;
    const dashSpace = 3.0;
    double startAngle = 0;

    while (startAngle < 2 * math.pi) {
      final endAngle = math.min(startAngle + dashWidth / radius, 2 * math.pi);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
      startAngle += (dashWidth + dashSpace) / radius;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
