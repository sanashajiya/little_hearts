import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:little_hearts/core/constants/custom_text.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../bloc/go_online_bloc.dart';
import '../bloc/go_online_event.dart';
import '../bloc/go_online_state.dart';
import '../widgets/female_app_bar.dart';
import '../widgets/call_toggle_row.dart';
import '../widgets/monthly_bonus_card.dart';
import '../widgets/bonus_rewards_card.dart';
import '../../../explore/presentation/widgets/female_bottom_navigation_bar.dart';

class GoOnlineScreen extends StatelessWidget {
  const GoOnlineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);

    return BlocProvider(
      create: (_) => GoOnlineBloc()..add(const GoOnlineInitialized()),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                zoneTheme.dark.withOpacity(0.99),
                zoneTheme.light.withOpacity(0.5),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                
                 Material(
                  elevation: 2,
                  shadowColor: Colors.black.withOpacity(0.2),
                  type: MaterialType.transparency,
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Expanded(
                          child: Center(
                            child: CustomText(
                              text: 'Go Online',
                              fontSize: 18,
                              fontWeight: FontWeightType.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 48), // balance center title
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: BlocBuilder<GoOnlineBloc, GoOnlineState>(
                      builder: (context, state) {
                        return SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              CallToggleRow(
                                icon: Icons.mic,
                                label: 'Audio Call',
                                isEnabled: state.isAudioCallEnabled,
                                onChanged: (value) {
                                  context.read<GoOnlineBloc>().add(
                                    AudioCallToggled(value),
                                  );
                                },
                                activeColor: zoneTheme.dark,
                              ),
                              CallToggleRow(
                                icon: Icons.videocam,
                                label: 'Video Call',
                                isEnabled: state.isVideoCallEnabled,
                                onChanged: (value) {
                                  context.read<GoOnlineBloc>().add(
                                    VideoCallToggled(value),
                                  );
                                },
                                activeColor: zoneTheme.primary,
                              ),
                              const SizedBox(height: 8),
                              MonthlyBonusCard(
                                period: state.monthlyBonusPeriod,
                              ),
                              BonusRewardsCard(rewards: state.bonusRewards),
                              const SizedBox(
                                height: 100,
                              ), // Space for bottom nav
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const FemaleBottomNavigationBar(
                  selectedItem: FemaleBottomNavItem.goOnline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
