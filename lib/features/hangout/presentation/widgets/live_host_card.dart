import 'package:flutter/material.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/live_room_host.dart';

/// Live Host Card Widget
class LiveHostCard extends StatelessWidget {
  final LiveRoomHost host;
  final int viewerCount;

  const LiveHostCard({
    super.key,
    required this.host,
    required this.viewerCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.hangoutModeLight.withOpacity(0.35),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Host Image with Glow Effect
          Stack(
            alignment: Alignment.center,
            children: [
              // Glow Effect
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Colors.purple.withOpacity(0.25),
                      Colors.pink.withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              // Host Image
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.hangoutMode,
                    width: 3,
                  ),
                ),
                child: ClipOval(
                  child: Image.asset(
                    host.profileImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Live Badge
              Positioned(
                bottom: 10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.hangoutMode.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.hangoutMode)
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: Colors.red,
                      ),
                      SizedBox(width: 4),
                      CustomText(
                        text: 'Live',
                        fontSize: 10,
                        fontWeight: FontWeightType.semiBold,
                        color: AppColors.hangoutModeDark,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 2),

          /// Host Name
          CustomText(
            text: host.name,
            fontSize: 18,
            fontWeight: FontWeightType.bold,
            color: AppColors.textPrimary,
          ),

          const SizedBox(height: 4),

          /// Host Info
          CustomText(
            text:
                'Host • ${_formatFollowerCount(host.followerCount)} followers',
            fontSize: 12,
            fontWeight: FontWeightType.medium,
            color: AppColors.black,
          ),
        ],
      ),
    );
  }

  String _formatFollowerCount(int count) {
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }
}
