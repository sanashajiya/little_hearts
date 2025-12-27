import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/leaderboard_type.dart';
import '../../domain/entities/leaderboard_zone.dart';
import '../bloc/leaderboard_bloc.dart';
import '../bloc/leaderboard_event.dart';
import '../bloc/leaderboard_state.dart';
import '../widgets/leaderboard_app_bar.dart';
import '../widgets/leaderboard_list_item.dart';
import '../widgets/leaderboard_type_tabs.dart';
import '../widgets/top_three_widget.dart';
import '../widgets/zone_selector_tabs.dart';

class LeaderboardScreen extends StatefulWidget {
  final LeaderboardZone? initialZone;

  const LeaderboardScreen({super.key, this.initialZone});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  late LeaderboardBloc _bloc;
  late LeaderboardZone _currentZone;
  late LeaderboardType _currentType;

  @override
  void initState() {
    super.initState();
    _currentZone = widget.initialZone ?? LeaderboardZone.friend;
    _currentType = LeaderboardType.topEarner;
    _bloc = LeaderboardBloc();
    _bloc.add(LoadLeaderboard(zone: _currentZone, type: _currentType));
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  LinearGradient _getGradientForZone(LeaderboardZone zone) {
    switch (zone) {
      case LeaderboardZone.friend:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.friendModeLight, AppColors.white],
        );
      case LeaderboardZone.date:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.dateModeLight, AppColors.white],
        );
      case LeaderboardZone.hangout:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.hangoutModeLight, AppColors.white],
        );
    }
  }

  /// 👉 DARK COLOR for AppBar
  Color _getDarkColorForZone(LeaderboardZone zone) {
    switch (zone) {
      case LeaderboardZone.friend:
        return AppColors.friendModeDark.withOpacity(0.9);
      case LeaderboardZone.date:
        return AppColors.dateModeDark.withOpacity(0.9);
      case LeaderboardZone.hangout:
        return AppColors.hangoutModeDark.withOpacity(0.9);
    }
  }

  Color _getColorForZone(LeaderboardZone zone) {
    switch (zone) {
      case LeaderboardZone.friend:
        return AppColors.friendMode;
      case LeaderboardZone.date:
        return AppColors.dateMode;
      case LeaderboardZone.hangout:
        return AppColors.hangoutMode;
    }
  }

  void _onZoneChanged(LeaderboardZone zone) {
    setState(() => _currentZone = zone);
    _bloc.add(ChangeZone(zone));
  }

  void _onTypeChanged(LeaderboardType type) {
    setState(() => _currentType = type);
    _bloc.add(ChangeLeaderboardType(type));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _bloc,
      child: Scaffold(
        /// ✅ AppBar uses ONLY dark zone color
        appBar: LeaderboardAppBar(
          backgroundColor: _getDarkColorForZone(_currentZone),
        ),

        /// ✅ Body uses gradient
        body: Container(
          decoration: BoxDecoration(
            gradient: _getGradientForZone(_currentZone),
          ),
          child: BlocBuilder<LeaderboardBloc, LeaderboardState>(
            builder: (context, state) {
              if (state is LeaderboardLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }

              if (state is LeaderboardError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.message,
                        style: const TextStyle(color: AppColors.error),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          _bloc.add(
                            LoadLeaderboard(
                              zone: _currentZone,
                              type: _currentType,
                            ),
                          );
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (state is LeaderboardLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10,),
                      ZoneSelectorTabs(
                        selectedZone: state.zone,
                        activeColor: _getColorForZone(state.zone),
                        onZoneChanged: _onZoneChanged,
                      ),
                      LeaderboardTypeTabs(
                        selectedType: state.type,
                        activeColor: _getColorForZone(state.zone),
                        onTypeChanged: _onTypeChanged,
                      ),
                      TopThreeWidget(
                        topThree: state.topThree,
                        type: state.type,
                        zoneColor: _getColorForZone(state.zone),
                      ),
                      const SizedBox(height: 16),
                      if (state.rest.isNotEmpty)
                        ...state.rest.map(
                          (entry) => LeaderboardListItem(
                            entry: entry,
                            type: state.type,
                            badgeColor: _getColorForZone(state.zone),
                          ),
                        ),
                      const SizedBox(height: 16),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
