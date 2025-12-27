import 'package:equatable/equatable.dart';

import '../../domain/entities/buddy.dart';
import '../../domain/entities/most_engaged.dart';
import 'female_explore_event.dart';

enum FemaleExploreViewMode {
  initial,
  allBuddies,
  allMostEngaged,
}

class FemaleExploreState extends Equatable {
  final FemaleExploreFilter currentFilter;
  final FemaleExploreViewMode viewMode;
  final List<Buddy> buddies;
  final List<MostEngaged> mostEngaged;

  const FemaleExploreState({
    this.currentFilter = FemaleExploreFilter.mostRelevant,
    this.viewMode = FemaleExploreViewMode.initial,
    this.buddies = const [],
    this.mostEngaged = const [],
  });

  FemaleExploreState copyWith({
    FemaleExploreFilter? currentFilter,
    FemaleExploreViewMode? viewMode,
    List<Buddy>? buddies,
    List<MostEngaged>? mostEngaged,
  }) {
    return FemaleExploreState(
      currentFilter: currentFilter ?? this.currentFilter,
      viewMode: viewMode ?? this.viewMode,
      buddies: buddies ?? this.buddies,
      mostEngaged: mostEngaged ?? this.mostEngaged,
    );
  }

  @override
  List<Object?> get props => [currentFilter, viewMode, buddies, mostEngaged];
}



