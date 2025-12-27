enum FemaleExploreFilter {
  mostRelevant,
  online,
  offline,
  nearby,
}

abstract class FemaleExploreEvent {}

class FemaleExploreInitialized extends FemaleExploreEvent {}

class FemaleExploreFilterChanged extends FemaleExploreEvent {
  final FemaleExploreFilter filter;

  FemaleExploreFilterChanged(this.filter);
}

class ShowAllBuddies extends FemaleExploreEvent {}

class ShowAllMostEngaged extends FemaleExploreEvent {}

class ShowInitialView extends FemaleExploreEvent {}



