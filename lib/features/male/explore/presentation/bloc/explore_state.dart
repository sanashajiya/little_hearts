import 'package:equatable/equatable.dart';

import '../../domain/entities/gicon.dart';
import '../../domain/entities/gstar.dart';
import 'explore_event.dart';

enum ExploreViewMode {
  initial,
  allGIcons,
  allGStars,
}

class ExploreState extends Equatable {
  final ExploreFilter currentFilter;
  final ExploreViewMode viewMode;
  final List<GIcon> gIcons;
  final List<GStar> gStars;

  const ExploreState({
    this.currentFilter = ExploreFilter.mostRelevant,
    this.viewMode = ExploreViewMode.initial,
    this.gIcons = const [],
    this.gStars = const [],
  });

  ExploreState copyWith({
    ExploreFilter? currentFilter,
    ExploreViewMode? viewMode,
    List<GIcon>? gIcons,
    List<GStar>? gStars,
  }) {
    return ExploreState(
      currentFilter: currentFilter ?? this.currentFilter,
      viewMode: viewMode ?? this.viewMode,
      gIcons: gIcons ?? this.gIcons,
      gStars: gStars ?? this.gStars,
    );
  }

  @override
  List<Object?> get props => [currentFilter, viewMode, gIcons, gStars];
}


