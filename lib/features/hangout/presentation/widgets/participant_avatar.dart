import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/live_room_participant.dart';

/// Participant Avatar Widget
class ParticipantAvatar extends StatelessWidget {
  final LiveRoomParticipant participant;
  final double size;

  const ParticipantAvatar({
    super.key,
    required this.participant,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size + 24,
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.hangoutModeLight.withOpacity(0.35),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        // mainAxisSize: MainAxisSi.ze.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Avatar
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.hangoutMode,
                width: 2,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                participant.profileImage,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 4),

          /// Name
          CustomText(
            text: participant.name,
            fontSize: 12,
            fontWeight: FontWeightType.medium,
            color: AppColors.textPrimary,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
