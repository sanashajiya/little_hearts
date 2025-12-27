import 'package:flutter/material.dart';

/// Rating Stars Widget
class RatingStars extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color starColor;

  const RatingStars({
    super.key,
    required this.rating,
    this.starSize = 16,
    this.starColor = const Color(0xFFFFD700), // Gold color
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Icon(
          Icons.star,
          size: starSize,
          color: starColor,
        );
      }),
    );
  }
}

