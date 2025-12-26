import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/most_engaged.dart';
import '../../../../male/explore/domain/entities/gicon.dart';
import '../../../../../core/constants/custom_text.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/zone_theme.dart';

class EngagedCard extends StatelessWidget {
  final MostEngaged mostEngaged;
  final VoidCallback onJoin;

  const EngagedCard({
    super.key,
    required this.mostEngaged,
    required this.onJoin,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

    return GestureDetector(
      // onTap: () => context.push('/view-profile', extra: mostEngaged.name),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 4 / 4,
                    child: Image.asset(
                      mostEngaged.imageAsset,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: '${mostEngaged.name} ${mostEngaged.age}',
                        fontSize: 12,
                        fontWeight: FontWeightType.bold,
                        color: AppColors.textPrimary,
                      ),
                      CustomText(
                        text: mostEngaged.location,
                        fontSize: 11,
                        fontWeight: FontWeightType.regular,
                        color: AppColors.black,
                      ),
                      const SizedBox(height: 4),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SizedBox(
                          width: double.infinity,
                          height: 28,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: theme.dark,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            onPressed: onJoin,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  mostEngaged.callType == CallType.audio
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Status Dot - positioned at top-right of card
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: _getStatusColor(mostEngaged.status),
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


