import 'package:flutter/material.dart';
import 'package:little_hearts/core/theme/app_colors.dart';

class ProfileAvatar extends StatelessWidget {
  final String imagePath;
  final double size;
  final bool showCrown;

  const ProfileAvatar({
    super.key,
    required this.imagePath,
    this.size = 60,
    this.showCrown = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.person, color: Colors.grey),
                );
              },
            ),
          ),
        ),
        if (showCrown)
          Positioned(
            top: -18,
            left: size / 2 - 12,
            child: Image.asset(
              'assets/icons/crown.png',
              width: 32,
              height: 32,
              color: Colors.amber,
            ),
          ),
      ],
    );
  }
}

