import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/gicon.dart';
import '../../domain/entities/gstar.dart';
import 'explore_event.dart';
import 'explore_state.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  ExploreBloc() : super(const ExploreState()) {
    on<ExploreInitialized>(_onInitialized);
    on<ExploreFilterChanged>(_onFilterChanged);
    on<ShowAllGIcons>(_onShowAllGIcons);
    on<ShowAllGStars>(_onShowAllGStars);
    on<ShowInitialView>(_onShowInitialView);
  }

  void _onInitialized(
    ExploreInitialized event,
    Emitter<ExploreState> emit,
  ) {
    // Static data; later can be replaced with repository calls.
    const gIcons = [
      GIcon(
        name: 'Meghana',
        age: 26,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gicon1.png',
      ),
      GIcon(
        name: 'Sandhya',
        age: 27,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gicon2.png',
      ),
      GIcon(
        name: 'Fathima',
        age: 22,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gicon3.png',
      ),
      GIcon(
        name: 'Catherine',
        age: 25,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gicon4.png',
      ),
      GIcon(
        name: 'Hayathi',
        age: 29,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gicon5.png',
      ),
      GIcon(
        name: 'Suhana',
        age: 24,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gicon6.png',
      ),
      GIcon(
        name: 'Divya',
        age: 23,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gicon7.png',
      ),
      GIcon(
        name: 'Anjali',
        age: 28,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gicon8.png',
      ),
    ];

    const gStars = [
      GStar(
        name: 'Divi234',
        age: 26,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gstar1.png',
      ),
      GStar(
        name: 'Akhila212',
        age: 28,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gstar2.png',
      ),
      GStar(
        name: 'Swaroopa',
        age: 22,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gstar3.png',
      ),
      GStar(
        name: 'Hasini324@',
        age: 28,
        location: 'Hyderabad',
        imageAsset: 'assets/images/gstar4.png',
      ),
    ];

    emit(
      state.copyWith(
        gIcons: gIcons,
        gStars: gStars,
      ),
    );
  }

  void _onFilterChanged(
    ExploreFilterChanged event,
    Emitter<ExploreState> emit,
  ) {
    emit(state.copyWith(currentFilter: event.filter));
  }

  void _onShowAllGIcons(
    ShowAllGIcons event,
    Emitter<ExploreState> emit,
  ) {
    emit(state.copyWith(viewMode: ExploreViewMode.allGIcons));
  }

  void _onShowAllGStars(
    ShowAllGStars event,
    Emitter<ExploreState> emit,
  ) {
    emit(state.copyWith(viewMode: ExploreViewMode.allGStars));
  }

  void _onShowInitialView(
    ShowInitialView event,
    Emitter<ExploreState> emit,
  ) {
    emit(state.copyWith(viewMode: ExploreViewMode.initial));
  }
}


