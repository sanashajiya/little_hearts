import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/zone_theme.dart';
import '../../../../core/widgets/bottom_navigation_bar.dart';
import '../../../../core/cubit/zone_cubit.dart';
import '../cubit/view_profile_cubit.dart';
import '../widgets/view_profile_header.dart';
import '../widgets/profile_summary_row.dart';
import '../widgets/profile_meta_info.dart';
import '../widgets/profile_action_card.dart';
import '../widgets/bio_card.dart';
import '../widgets/languages_card.dart';
import '../widgets/previous_stories_card.dart';
import '../widgets/view_profile_ratings_card.dart';

class ViewProfileScreen extends StatelessWidget {
  final String? userId;

  const ViewProfileScreen({
    super.key,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ViewProfileCubit(),
      child: const _ViewProfileView(),
    );
  }
}

class _ViewProfileView extends StatelessWidget {
  const _ViewProfileView();

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final theme = ZoneTheme.fromMode(mode);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.dark,
              theme.light,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const ViewProfileHeader(),
              Expanded(
                child: BlocBuilder<ViewProfileCubit, ViewProfileState>(
                  builder: (context, state) {
                    if (state is ViewProfileLoaded) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileSummaryRow(
                              followersCount: state.profile.followersCount,
                              followingCount: state.profile.followingCount,
                            ),
                            const SizedBox(height: 8),
                            ProfileMetaInfo(
                              name: state.profile.name,
                              age: state.profile.age,
                              lastSeen: state.profile.lastSeen,
                              birthday: state.profile.birthday,
                              location: state.profile.location,
                            ),
                            const SizedBox(height: 16),
                            // Action Cards Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: ProfileActionCard(
                                    icon: Icons.mic,
                                    label: 'Audio',
                                    pricePerMin: state.profile.audioPricePerMin,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ProfileActionCard(
                                    icon: Icons.videocam,
                                    label: 'Video',
                                    pricePerMin: state.profile.videoPricePerMin,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: ProfileActionCard(
                                    icon: Icons.chat_bubble_outline,
                                    label: 'Chat',
                                    pricePerMin: state.profile.chatPricePerMin,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            BioCard(bio: state.profile.bio),
                            const SizedBox(height: 8),
                            LanguagesCard(languages: state.profile.languages),
                            const SizedBox(height: 8),
                            PreviousStoriesCard(
                              stories: state.profile.stories,
                            ),
                            const SizedBox(height: 8),
                            ViewProfileRatingsCard(
                              rating: state.profile.rating,
                              ratingCount: state.profile.ratingCount,
                              conversationMinutes:
                                  state.profile.conversationMinutes,
                              starsGifted: state.profile.starsGifted,
                              followingSince: state.profile.followingSince,
                            ),
                            const SizedBox(height: 50), // Space for bottom nav
                          ],
                        ),
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
              const AppBottomNavigationBar(
                selectedItem: BottomNavItem.profile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

