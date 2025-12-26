import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/cubit/zone_cubit.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../domain/entities/buddy.dart';
import '../../domain/entities/most_engaged.dart';
import '../bloc/female_explore_bloc.dart';
import '../bloc/female_explore_event.dart';
import '../bloc/female_explore_state.dart';
import '../widgets/buddy_card.dart';
import '../widgets/engaged_card.dart';
import '../widgets/female_bottom_navigation_bar.dart';
import '../widgets/female_explore_appbar.dart';
import '../widgets/female_explore_search_bar.dart';
import '../widgets/see_more_card.dart';

class FemaleExploreScreen extends StatelessWidget {
  const FemaleExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FemaleExploreBloc()..add(FemaleExploreInitialized()),
      child: const _FemaleExploreView(),
    );
  }
}

class _FemaleExploreView extends StatelessWidget {
  const _FemaleExploreView();

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);

    return Scaffold(
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
              BlocBuilder<FemaleExploreBloc, FemaleExploreState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                    child: FemaleExploreAppBar(
                      onBack: () {
                        context.go('/home');
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: FemaleExploreSearchBar(onChanged: (_) {}),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: BlocBuilder<FemaleExploreBloc, FemaleExploreState>(
                    builder: (context, state) {
                      // switch (state.viewMode) {
                      //   case ExploreViewMode.allGIcons:
                      //     return _buildBuddiesSection(context, state);
                      //   case ExploreViewMode.allGStars:
                      //     return _buildMostEngagedSection(context, state);
                      //   case ExploreViewMode.initial:
                      //     return _buildInitialView(context, state);
                      // }
                      return _buildInitialView(context, state);
                    },
                  ),
                ),
              ),
              const FemaleBottomNavigationBar(
                selectedItem: FemaleBottomNavItem.explore,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialView(BuildContext context, FemaleExploreState state) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      children: [
        _buildBuddiesSection(context, state.buddies),
        const SizedBox(height: 24),
        _buildMostEngagedSection(context, state.mostEngaged),
      ],
    );
  }

  Widget _buildBuddiesSection(BuildContext context, List<Buddy> buddies) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Buddies',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            PopupMenuButton<FemaleExploreFilter>(
              icon: const Icon(Icons.filter_list, color: AppColors.textPrimary),
              position: PopupMenuPosition.under,
              onSelected: (filter) {
                context.read<FemaleExploreBloc>().add(
                  FemaleExploreFilterChanged(filter),
                );
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: FemaleExploreFilter.mostRelevant,
                  child: Text('Most Relevant'),
                ),
                PopupMenuItem(
                  value: FemaleExploreFilter.online,
                  child: Text('Online'),
                ),
                PopupMenuItem(
                  value: FemaleExploreFilter.offline,
                  child: Text('Offline'),
                ),
                PopupMenuItem(
                  value: FemaleExploreFilter.nearby,
                  child: Text('Near by'),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 2),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 5 + 1, // First 5 + See More card
          itemBuilder: (context, index) {
            if (index == 5) {
              return SeeMoreCard(
                title: 'See More\nProfile',
                onTap: () {
                  final bloc = context.read<FemaleExploreBloc>();
                  context.push('/female/buddies-see-more', extra: bloc);
                },
              );
            }
            final buddy = buddies[index];
            return BuddyCard(buddy: buddy, onJoin: () {});
          },
        ),
      ],
    );
  }

  Widget _buildMostEngagedSection(
    BuildContext context,
    List<MostEngaged> mostEngaged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Most Engaged',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () {
                final bloc = context.read<FemaleExploreBloc>();
                context.push('/female/most-engaged-view-more', extra: bloc);
              },
              child: Builder(
                builder: (context) {
                  final mode = context.watch<ZoneCubit>().state;
                  final theme = ZoneTheme.fromMode(mode);
                  return Text(
                    'View More',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: theme.primary,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.65,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: 4, // First 4 only
          itemBuilder: (context, index) {
            final engaged = mostEngaged[index];
            return EngagedCard(mostEngaged: engaged, onJoin: () {});
          },
        ),
      ],
    );
  }
}
