import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/zone_theme.dart';
import '../../../../../core/cubit/zone_cubit.dart';
import '../widgets/female_bottom_navigation_bar.dart';
import '../bloc/female_explore_bloc.dart';
import '../bloc/female_explore_event.dart';
import '../bloc/female_explore_state.dart';
import '../widgets/engaged_card.dart';

class MostEngagedViewMoreScreen extends StatelessWidget {
  final FemaleExploreBloc? bloc;

  const MostEngagedViewMoreScreen({super.key, this.bloc});

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
                      'Most Engaged',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              // All Most Engaged Grid
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
                            crossAxisCount: 2,
                            childAspectRatio: 0.65,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: state.mostEngaged.length,
                          itemBuilder: (context, index) {
                            final engaged = state.mostEngaged[index];
                            return EngagedCard(
                              mostEngaged: engaged,
                              onJoin: () {},
                            );
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

