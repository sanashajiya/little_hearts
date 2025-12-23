import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/zone_theme.dart';
import '../../../../core/cubit/zone_cubit.dart';

class CallActionSection extends StatelessWidget {
  final VoidCallback? onAudioCallTap;
  final VoidCallback? onVideoCallTap;

  const CallActionSection({
    super.key,
    this.onAudioCallTap,
    this.onVideoCallTap,
  });

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildCallButton(
          icon: Icons.mic,
          coinCost: 10,
          label: 'Random Audio',
          onTap: onAudioCallTap,
          theme: theme,
        ),
        _buildCallButton(
          icon: Icons.videocam,
          coinCost: 50,
          label: 'Random Video',
          onTap: onVideoCallTap,
          theme: theme,
        ),
      ],
    );
  }

  Widget _buildCallButton({
    required IconData icon,
    required int coinCost,
    required String label,
    required VoidCallback? onTap,
    required ZoneTheme theme,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          // decoration: BoxDecoration(
          //   // color: Colors.white,
          //   borderRadius: BorderRadius.circular(16),
          //   border: Border.all(color: AppColors.borderLight),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black.withValues(alpha: 0.05),
          //       blurRadius: 10,
          //       offset: const Offset(0, 4),
          //     ),
          //   ],
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: theme.dark.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  color: AppColors.white,
                  size: 22,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/coin.png',
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(width: 4),
                  CustomText(
                    text: '$coinCost coins / Min',
                    fontSize: 12,
                    fontWeight: FontWeightType.medium,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              CustomText(
                text: label,
                fontSize: 12,
                fontWeight: FontWeightType.bold,
                // color: AppColors.friendModeDark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

