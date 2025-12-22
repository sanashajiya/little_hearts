enum ExploreFilter {
  mostRelevant,
  online,
  offline,
  nearby,
}

abstract class ExploreEvent {}

class ExploreInitialized extends ExploreEvent {}

class ExploreFilterChanged extends ExploreEvent {
  final ExploreFilter filter;

  ExploreFilterChanged(this.filter);
}

class ExploreGIconsViewMoreRequested extends ExploreEvent {}

class ExploreGStarsViewMoreRequested extends ExploreEvent {}


