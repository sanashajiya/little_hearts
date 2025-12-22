import 'package:equatable/equatable.dart';

import '../../domain/entities/gicon.dart';
import '../../domain/entities/gstar.dart';
import 'explore_event.dart';

class ExploreState extends Equatable {
  final ExploreFilter currentFilter;
  final List<GIcon> gIcons;
  final List<GStar> gStars;

  const ExploreState({
    this.currentFilter = ExploreFilter.mostRelevant,
    this.gIcons = const [],
    this.gStars = const [],
  });

  ExploreState copyWith({
    ExploreFilter? currentFilter,
    List<GIcon>? gIcons,
    List<GStar>? gStars,
  }) {
    return ExploreState(
      currentFilter: currentFilter ?? this.currentFilter,
      gIcons: gIcons ?? this.gIcons,
      gStars: gStars ?? this.gStars,
    );
  }

  @override
  List<Object?> get props => [currentFilter, gIcons, gStars];
}


