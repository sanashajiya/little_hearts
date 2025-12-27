import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/custom_text.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/audio_live_room_bloc.dart';
import '../bloc/audio_live_room_event.dart';
import '../bloc/audio_live_room_state.dart';
import '../widgets/live_badge.dart';
import '../widgets/live_host_card.dart';
import '../widgets/participants_list.dart';
import '../widgets/waitlist_item.dart';
import '../widgets/join_button.dart';
import '../widgets/chat_input_bar.dart';
import '../widgets/report_bottom_sheet.dart';
import '../../data/repositories/live_room_repository_impl.dart';

/// Audio Live Room Screen
class AudioLiveRoomScreen extends StatelessWidget {
  final String topic;
  final String roomId;

  const AudioLiveRoomScreen({
    super.key,
    required this.topic,
    required this.roomId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AudioLiveRoomBloc(
        repository: LiveRoomRepositoryImpl(),
      )..add(LoadLiveRoom(roomId: roomId, topic: topic)),
      child: const _AudioLiveRoomView(),
    );
  }
}

class _AudioLiveRoomView extends StatelessWidget {
  const _AudioLiveRoomView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.hangoutModeLight,
              AppColors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<AudioLiveRoomBloc, AudioLiveRoomState>(
            builder: (context, state) {
              // Show report bottom sheet if in report state
              if (state is ReportBottomSheetState) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    final bloc = context.read<AudioLiveRoomBloc>();
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (bottomSheetContext) => BlocProvider.value(
                        value: bloc,
                        child: const ReportBottomSheet(),
                      ),
                    ).then((_) {
                      // After bottom sheet closes, restore the previous state
                      if (context.mounted) {
                        final currentState = bloc.state;
                        if (currentState is ReportBottomSheetState) {
                          // Restore to the previous state based on whether user was joined
                          if (currentState.room.isJoined) {
                            bloc.add(const JoinRoom());
                          } else {
                            bloc.add(LoadLiveRoom(
                              roomId: currentState.room.id,
                              topic: currentState.room.topic,
                            ));
                          }
                        }
                      }
                    });
                  }
                });
              }

              if (state is LiveRoomLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.hangoutMode,
                  ),
                );
              }

              if (state is LiveRoomError) {
                return Center(
                  child: CustomText(
                    text: 'Error: ${state.message}',
                    fontSize: 14,
                    color: AppColors.error,
                  ),
                );
              }

              if (state is LiveRoomLoaded || state is LiveRoomJoined) {
                final room = state is LiveRoomLoaded
                    ? state.room
                    : (state as LiveRoomJoined).room;
                final isJoined = state is LiveRoomJoined;

                return Column(
                  children: [ 
                    // AppBar
                    _buildAppBar(context, room.topic),
                    const SizedBox(height: 8),
                    // Live Badge
                    LiveBadge(viewerCount: room.liveViewerCount),
                    const SizedBox(height: 24),
                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            // Host Section
                            LiveHostCard(
                              host: room.host,
                              viewerCount: room.liveViewerCount,
                            ),
                            const SizedBox(height: 32),
                            // Participants Section
                            ParticipantsList(participants: room.participants),
                            const SizedBox(height: 24),
                            // Waitlist Section
                            Align(
                               alignment: Alignment.centerLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: 'Waitlist (${room.waitlist.length})',
                                    fontSize: 16,
                                    fontWeight: FontWeightType.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                  const SizedBox(height: 12),
                                  ...room.waitlist.map(
                                    (name) => WaitlistItem(name: name),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 100), // Space for bottom button/input
                          ],
                        ),
                      ),
                    ),
                    // Join Button or Chat Input
                    if (!isJoined)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: JoinButton(
                          onPressed: () {
                            context.read<AudioLiveRoomBloc>().add(const JoinRoom());
                          },
                        ),
                      )
                    else
                      ChatInputBar(
                        onSend: (message) {
                          context.read<AudioLiveRoomBloc>().add(
                                SendMessage(message: message),
                              );
                        },
                      ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, String topic) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () => context.pop(),
          ),
          CustomText(
            text: 'Topic : $topic',
            fontSize: 20,
            fontWeight: FontWeightType.semiBold,
            color: Colors.black,
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.black,
              size: 24,
            ),
            onPressed: () {
              context.read<AudioLiveRoomBloc>().add(const OpenReport());
            },
          ),
        ],
      ),
    );
  }
}

