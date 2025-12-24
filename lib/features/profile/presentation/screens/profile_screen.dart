import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/zone_theme.dart';
import '../../../../core/widgets/bottom_navigation_bar.dart';
import '../../../../core/cubit/zone_cubit.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info_section.dart';
import '../widgets/bio_card.dart';
import '../widgets/previous_stories_card.dart';
import '../widgets/ratings_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: const _ProfileView(),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView();

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
              const ProfileHeader(),
              Expanded(
                child: BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    if (state is ProfileLoaded) {
                      return SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ProfileInfoSection(profile: state.profile),
                            // const SizedBox(height: 8),
                            BioCard(bio: state.profile.bio),
                            const SizedBox(height: 8),
                            PreviousStoriesCard(
                              stories: state.profile.stories,
                            ),
                            const SizedBox(height: 8),
                            RatingsCard(
                              rating: state.profile.rating,
                              ratingCount: state.profile.ratingCount,
                              profileCreatedDate:
                                  state.profile.profileCreatedDate,
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

