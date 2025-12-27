import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/live_room_participant.dart';
import 'participant_avatar.dart';

/// Participants List Widget
class ParticipantsList extends StatelessWidget {
  final List<LiveRoomParticipant> participants;

  const ParticipantsList({
    super.key,
    required this.participants,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Participants (${participants.length})',
          fontSize: 16,
          fontWeight: FontWeightType.bold,
          color: AppColors.textPrimary,
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: participants.length,
            separatorBuilder: (_, __) => const SizedBox(width: 20),
            itemBuilder: (context, index) {
              return ParticipantAvatar(participant: participants[index]);
            },
          ),
        ),
      ],
    );
  }
}

