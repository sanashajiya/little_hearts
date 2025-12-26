import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/zone_theme.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../widgets/female_bottom_navigation_bar.dart';
import '../bloc/female_explore_bloc.dart';
import '../bloc/female_explore_event.dart';
import '../bloc/female_explore_state.dart';
import '../widgets/buddy_card.dart';

class BuddiesSeeMoreScreen extends StatelessWidget {
  final FemaleExploreBloc? bloc;

  const BuddiesSeeMoreScreen({super.key, this.bloc});

  @override
  Widget build(BuildContext context) {
    final mode = context.watch<ZoneCubit>().state;
    final zoneTheme = ZoneTheme.fromMode(mode);
    
    // Use provided bloc, or try to get from context, or create new one
    FemaleExploreBloc providedBloc;
    if (bloc != null) {
      providedBloc = bloc!;
    } else {
      try {
        providedBloc = BlocProvider.of<FemaleExploreBloc>(context, listen: false);
      } catch (e) {
        providedBloc = FemaleExploreBloc()..add(FemaleExploreInitialized());
      }
    }

    return BlocProvider.value(
      value: providedBloc,
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
              // Header with back button
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                      color: Colors.white,
                      onPressed: () {
                        context.pop();
                      },
                    ),
                    const Text(
                      'Buddies',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    BlocBuilder<FemaleExploreBloc, FemaleExploreState>(
                      builder: (context, state) {
                        return PopupMenuButton<FemaleExploreFilter>(
                          icon: const Icon(
                            Icons.filter_list,
                            color: Colors.white,
                          ),
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
                        );
                      },
                    ),
                  ],
                ),
              ),
              // All Buddies Grid
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: BlocBuilder<FemaleExploreBloc, FemaleExploreState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          padding: const EdgeInsets.only(top: 20, bottom: 100),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 0.7,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: state.buddies.length,
                          itemBuilder: (context, index) {
                            final buddy = state.buddies[index];
                            return BuddyCard(buddy: buddy, onJoin: () {});
                          },
                        ),
                      );
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
    ),
    );
  }
}

