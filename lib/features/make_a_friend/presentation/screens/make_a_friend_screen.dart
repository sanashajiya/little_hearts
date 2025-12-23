import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/bottom_navigation_bar.dart';
import '../../data/repositories/make_a_friend_repository.dart';
import '../bloc/make_a_friend_bloc.dart';
import '../bloc/make_a_friend_event.dart';
import '../bloc/make_a_friend_state.dart';
import '../widgets/circular_avatar_layout.dart';
import '../widgets/call_action_section.dart';
import '../widgets/make_a_friend_app_bar.dart';

class MakeAFriendScreen extends StatelessWidget {
  const MakeAFriendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MakeAFriendBloc(
        repository: MakeAFriendRepositoryImpl(),
      )..add(const MakeAFriendInitialized()),
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.friendModeDark,
                AppColors.friendModeLight.withValues(alpha: 0.5),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                const MakeAFriendAppBar(),
                Expanded(
                  child: BlocBuilder<MakeAFriendBloc, MakeAFriendState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }

                      if (state.errorMessage != null) {
                        return Center(
                          child: Text(
                            state.errorMessage!,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      final avatars = state.currentAvatars;
                      if (avatars.isEmpty) {
                        return const Center(
                          child: Text(
                            'No avatars available',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }

                      // Center avatar (first one)
                      final centerAvatar = avatars[0];
                      // Surrounding avatars (next 5)
                      final surroundingAvatars = avatars.length > 5
                          ? avatars.sublist(1, 6)
                          : avatars.sublist(1);

                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 24,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            CircularAvatarLayout(
                              centerAvatar: centerAvatar,
                              surroundingAvatars: surroundingAvatars,
                            ),
                            const SizedBox(height: 40),
                            CallActionSection(
                              onAudioCallTap: () {
                                context.read<MakeAFriendBloc>().add(
                                      const RandomCallRequested(
                                        isVideoCall: false,
                                      ),
                                    );
                                // TODO: Navigate to audio call screen
                              },
                              onVideoCallTap: () {
                                context.read<MakeAFriendBloc>().add(
                                      const RandomCallRequested(
                                        isVideoCall: true,
                                      ),
                                    );
                                // TODO: Navigate to video call screen
                              },
                            ),
                            // const SizedBox(height: 100), // Space for bottom nav
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const AppBottomNavigationBar(
                  selectedItem: BottomNavItem.makeAFriend,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

