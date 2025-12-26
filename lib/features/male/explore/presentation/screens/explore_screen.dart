import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/zone_theme.dart';
import '../../../../../core/widgets/bottom_navigation_bar.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../../domain/entities/gicon.dart';
import '../../domain/entities/gstar.dart';
import '../bloc/explore_bloc.dart';
import '../bloc/explore_event.dart';
import '../bloc/explore_state.dart';
import '../widgets/explore_app_bar.dart';
import '../widgets/explore_search_bar.dart';
import '../widgets/gicon_card.dart';
import '../widgets/gstar_card.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ExploreBloc()..add(ExploreInitialized()),
      child: const _ExploreView(),
    );
  }
}

class _ExploreView extends StatelessWidget {
  const _ExploreView();

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
              BlocBuilder<ExploreBloc, ExploreState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
                    child: ExploreAppBar(
                      onBack: () {
                        if (state.viewMode != ExploreViewMode.initial) {
                          context.read<ExploreBloc>().add(ShowInitialView());
                        } else {
                          context.go('/home');
                        }
                      },
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: ExploreSearchBar(onChanged: (_) {}),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: BlocBuilder<ExploreBloc, ExploreState>(
                    builder: (context, state) {
                      switch (state.viewMode) {
                        case ExploreViewMode.allGIcons:
                          return _buildAllGIconsView(context, state);
                        case ExploreViewMode.allGStars:
                          return _buildAllGStarsView(context, state);
                        case ExploreViewMode.initial:
                          return _buildInitialView(context, state);
                      }
                    },
                  ),
                ),
              ),
              const AppBottomNavigationBar(selectedItem: BottomNavItem.explore),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInitialView(BuildContext context, ExploreState state) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
      children: [
        _buildGIconsSection(context, state.gIcons),
        const SizedBox(height: 24),
        _buildGStarsSection(context, state.gStars),
      ],
    );
  }

  Widget _buildAllGIconsView(BuildContext context, ExploreState state) {
    return Column(
      children: [
        // Header with back button
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                onPressed: () {
                  context.read<ExploreBloc>().add(ShowInitialView());
                },
              ),
              const Text(
                'GIcons',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              PopupMenuButton<ExploreFilter>(
                icon: const Icon(
                  Icons.filter_list,
                  color: AppColors.textPrimary,
                ),
                position: PopupMenuPosition.under,
                onSelected: (filter) {
                  context.read<ExploreBloc>().add(ExploreFilterChanged(filter));
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: ExploreFilter.mostRelevant,
                    child: Text('Most Relevant'),
                  ),
                  PopupMenuItem(
                    value: ExploreFilter.online,
                    child: Text('Online'),
                  ),
                  PopupMenuItem(
                    value: ExploreFilter.offline,
                    child: Text('Offline'),
                  ),
                  PopupMenuItem(
                    value: ExploreFilter.nearby,
                    child: Text('Near by'),
                  ),
                ],
              ),
            ],
          ),
        ),
        // All GIcons Grid
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.7,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.gIcons.length,
              itemBuilder: (context, index) {
                final gIcon = state.gIcons[index];
                return GIconCard(gIcon: gIcon, onJoin: () {});
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAllGStarsView(BuildContext context, ExploreState state) {
    return Column(
      children: [
        // Header with back button
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                onPressed: () {
                  context.read<ExploreBloc>().add(ShowInitialView());
                },
              ),
              const Text(
                'GStars',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              PopupMenuButton<ExploreFilter>(
                icon: const Icon(
                  Icons.filter_list,
                  color: AppColors.textPrimary,
                ),
                position: PopupMenuPosition.under,
                onSelected: (filter) {
                  context.read<ExploreBloc>().add(ExploreFilterChanged(filter));
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: ExploreFilter.mostRelevant,
                    child: Text('Most Relevant'),
                  ),
                  PopupMenuItem(
                    value: ExploreFilter.online,
                    child: Text('Online'),
                  ),
                  PopupMenuItem(
                    value: ExploreFilter.offline,
                    child: Text('Offline'),
                  ),
                  PopupMenuItem(
                    value: ExploreFilter.nearby,
                    child: Text('Near by'),
                  ),
                ],
              ),
            ],
          ),
        ),
        // All GStars Grid
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: state.gStars.length,
              itemBuilder: (context, index) {
                final gStar = state.gStars[index];
                return GStarCard(gStar: gStar, onJoin: () {});
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGIconsSection(BuildContext context, List<GIcon> gIcons) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'GIcons',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.black,
              ),
            ),
            PopupMenuButton<ExploreFilter>(
              icon: const Icon(Icons.filter_list, color: AppColors.textPrimary),
              position: PopupMenuPosition.under,
              onSelected: (filter) {
                context.read<ExploreBloc>().add(ExploreFilterChanged(filter));
              },
              itemBuilder: (context) => const [
                PopupMenuItem(
                  value: ExploreFilter.mostRelevant,
                  child: Text('Most Relevant'),
                ),
                PopupMenuItem(
                  value: ExploreFilter.online,
                  child: Text('Online'),
                ),
                PopupMenuItem(
                  value: ExploreFilter.offline,
                  child: Text('Offline'),
                ),
                PopupMenuItem(
                  value: ExploreFilter.nearby,
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
          itemCount: 5 + 1,
          itemBuilder: (context, index) {
            if (index == 5) {
              return _buildSeeMoreCard(
                context,
                title: 'See More\nProfile',
                onTap: () {
                  context.read<ExploreBloc>().add(ShowAllGIcons());
                },
              );
            }
            final gIcon = gIcons[index];
            return GIconCard(gIcon: gIcon, onJoin: () {});
          },
        ),
      ],
    );
  }

  Widget _buildGStarsSection(BuildContext context, List<GStar> gStars) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'GStars',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.read<ExploreBloc>().add(ShowAllGStars());
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
          itemCount: gStars.length,
          itemBuilder: (context, index) {
            final gStar = gStars[index];
            return GStarCard(gStar: gStar, onJoin: () {});
          },
        ),
      ],
    );
  }

  Widget _buildSeeMoreCard(
    BuildContext context, {
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Center(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
