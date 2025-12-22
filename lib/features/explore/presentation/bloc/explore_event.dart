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

class ShowAllGIcons extends ExploreEvent {}

class ShowAllGStars extends ExploreEvent {}

class ShowInitialView extends ExploreEvent {}


