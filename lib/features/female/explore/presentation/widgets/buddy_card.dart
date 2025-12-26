import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/buddy.dart';
import '../../../../male/explore/domain/entities/gicon.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/zone_theme.dart';

class BuddyCard extends StatelessWidget {
  final Buddy buddy;
  final VoidCallback onJoin;

  const BuddyCard({super.key, required this.buddy, required this.onJoin});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

    return GestureDetector(
      // onTap: () => context.push('/view-profile', extra: buddy.name),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage(buddy.imageAsset),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: CustomText(
                    text: '${buddy.name} ${buddy.age}',
                    fontSize: 12,
                    fontWeight: FontWeightType.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Center(
                  child: CustomText(
                    text: buddy.location,
                    fontSize: 11,
                    fontWeight: FontWeightType.regular,
                    color: AppColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  height: 28,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.dark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: onJoin,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          buddy.callType == CallType.audio
                              ? Icons.mic_none
                              : Icons.videocam,
                          size: 14,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 4),
                        const CustomText(
                          text: 'Join',
                          fontSize: 11,
                          fontWeight: FontWeightType.bold,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Status Dot
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _getStatusColor(buddy.status),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(UserStatus status) {
    switch (status) {
      case UserStatus.online:
        return Colors.green;
      case UserStatus.offline:
        return Colors.grey;
      case UserStatus.busy:
        return Colors.orange;
    }
  }
}


