import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../cubit/hangout_view_profile_cubit.dart';
import '../widgets/hangout_view_profile_header.dart';
import '../widgets/hangout_profile_summary_row.dart';
import '../widgets/hangout_profile_meta_info.dart';
import '../widgets/hangout_profile_action_card.dart';
import '../../../../features/female/profile/presentation/widgets/bio_card.dart';
import '../../../../features/female/profile/presentation/widgets/previous_stories_card.dart';
import '../widgets/hangout_languages_card.dart';
import '../widgets/hangout_view_profile_ratings_card.dart';

class HangoutViewProfileScreen extends StatelessWidget {
  final String name;
  final String profileImage;
  final bool isMale;

  const HangoutViewProfileScreen({
    super.key,
    required this.name,
    required this.profileImage,
    required this.isMale,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HangoutViewProfileCubit(
        name: name,
        profileImage: profileImage,
        isMale: isMale,
      ),
      child: const _HangoutViewProfileView(),
    );
  }
}

class _HangoutViewProfileView extends StatelessWidget {
  const _HangoutViewProfileView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.hangoutModeDark,
              AppColors.hangoutModeLight,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const HangoutViewProfileHeader(),
              Expanded(
                child: BlocBuilder<HangoutViewProfileCubit, HangoutViewProfileState>(
                  builder: (context, state) {
                    if (state is HangoutViewProfileLoaded) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            HangoutProfileSummaryRow(
                              profileImage: state.profile.profileImage,
                              followersCount: state.profile.followersCount,
                              followingCount: state.profile.followingCount,
                            ),
                            const SizedBox(height: 8),
                            HangoutProfileMetaInfo(
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
                                  child: HangoutProfileActionCard(
                                    icon: Icons.mic,
                                    label: 'Audio',
                                    pricePerMin: state.profile.audioPricePerMin,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: HangoutProfileActionCard(
                                    icon: Icons.videocam,
                                    label: 'Video',
                                    pricePerMin: state.profile.videoPricePerMin,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: HangoutProfileActionCard(
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
                            HangoutLanguagesCard(languages: state.profile.languages),
                            const SizedBox(height: 8),
                            PreviousStoriesCard(
                              stories: state.profile.stories,
                            ),
                            const SizedBox(height: 8),
                            HangoutViewProfileRatingsCard(
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
                        color: AppColors.white,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

