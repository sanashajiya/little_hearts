import 'package:flutter/material.dart';

import '../../domain/entities/gicon.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';

class GIconCard extends StatelessWidget {
  final GIcon gIcon;
  final VoidCallback onJoin;

  const GIconCard({
    super.key,
    required this.gIcon,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                backgroundImage: AssetImage(gIcon.imageAsset),
              ),
            ),
            //  Positioned(
            //         top: 2,
            //         left: 8,
            //         child: Container(
            //           width: 8,
            //           height: 8,
            //           decoration: const BoxDecoration(
            //             color: Colors.green,
            //             shape: BoxShape.circle,
            //           ),
            //         ),
            //       ),
            const SizedBox(height: 8),
            Center(
              child: CustomText(
                text: '${gIcon.name} ${gIcon.age}',
                fontSize: 12,
                fontWeight: FontWeightType.bold,
                color: AppColors.textPrimary,
              ),
            ),
            Center(
              child: CustomText(
                text: ' ${gIcon.location}',
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
                  backgroundColor: AppColors.friendModeDark,
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
                      gIcon.callType == CallType.audio
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
      // ✅ Status Dot
        Positioned(
          top: 8,
          right: 8,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: _getStatusColor(gIcon.status),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
            ),
          ),
        ),
      ],
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
