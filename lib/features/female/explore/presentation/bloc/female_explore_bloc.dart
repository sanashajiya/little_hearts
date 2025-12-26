import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/buddy.dart';
import '../../domain/entities/most_engaged.dart';
import '../../../../male/explore/domain/entities/gicon.dart';
import 'female_explore_event.dart';
import 'female_explore_state.dart';

class FemaleExploreBloc extends Bloc<FemaleExploreEvent, FemaleExploreState> {
  final Random _random = Random();

  FemaleExploreBloc() : super(const FemaleExploreState()) {
    on<FemaleExploreInitialized>(_onInitialized);
    on<FemaleExploreFilterChanged>(_onFilterChanged);
    on<ShowAllBuddies>(_onShowAllBuddies);
    on<ShowAllMostEngaged>(_onShowAllMostEngaged);
    on<ShowInitialView>(_onShowInitialView);
  }

  CallType _getRandomCallType() {
    return _random.nextBool() ? CallType.audio : CallType.video;
  }

  UserStatus _getRandomStatus() {
    final statuses = UserStatus.values;
    return statuses[_random.nextInt(statuses.length)];
  }

  void _onInitialized(
    FemaleExploreInitialized event,
    Emitter<FemaleExploreState> emit,
  ) {
    // Static dummy data for buddies (1-8)
    final buddies = [
      Buddy(
        name: 'Madhu',
        age: 26,
        location: 'Hyderabad',
        imageAsset: 'assets/images/buddy1.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      Buddy(
        name: 'Sandesh',
        age: 22,
        location: 'Hyderabad',
        imageAsset: 'assets/images/buddy2.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      Buddy(
        name: 'Daniel',
        age: 21,
        location: 'Hyderabad',
        imageAsset: 'assets/images/buddy3.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      Buddy(
        name: 'Sanjay',
        age: 22,
        location: 'Hyderabad',
        imageAsset: 'assets/images/buddy4.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      Buddy(
        name: 'ganesh',
        age: 25,
        location: 'Hyderabad',
        imageAsset: 'assets/images/buddy5.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      Buddy(
        name: 'Hayathi',
        age: 29,
        location: 'Hyderabad',
        imageAsset: 'assets/images/buddy6.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      Buddy(
        name: 'Daniel',
        age: 21,
        location: 'Hyderabad',
        imageAsset: 'assets/images/buddy7.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      Buddy(
        name: 'Sande',
        age: 24,
        location: 'Hyderabad',
        imageAsset: 'assets/images/buddy8.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
    ];

    // Static dummy data for most engaged (1-6)
    final mostEngaged = [
      MostEngaged(
        name: 'David',
        age: 26,
        location: 'Hyderabad',
        imageAsset: 'assets/images/most_engaged1.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      MostEngaged(
        name: 'Akhil',
        age: 28,
        location: 'Hyderabad',
        imageAsset: 'assets/images/most_engaged2.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      MostEngaged(
        name: 'Sathish',
        age: 22,
        location: 'Hyderabad',
        imageAsset: 'assets/images/most_engaged3.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      MostEngaged(
        name: 'Harish',
        age: 28,
        location: 'Hyderabad',
        imageAsset: 'assets/images/most_engaged4.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      MostEngaged(
        name: 'Ravi',
        age: 25,
        location: 'Hyderabad',
        imageAsset: 'assets/images/most_engaged5.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
      MostEngaged(
        name: 'Kiran',
        age: 27,
        location: 'Hyderabad',
        imageAsset: 'assets/images/most_engaged6.png',
        status: _getRandomStatus(),
        callType: _getRandomCallType(),
      ),
    ];

    emit(state.copyWith(buddies: buddies, mostEngaged: mostEngaged));
  }

  void _onFilterChanged(
    FemaleExploreFilterChanged event,
    Emitter<FemaleExploreState> emit,
  ) {
    emit(state.copyWith(currentFilter: event.filter));
  }

  void _onShowAllBuddies(
    ShowAllBuddies event,
    Emitter<FemaleExploreState> emit,
  ) {
    emit(state.copyWith(viewMode: FemaleExploreViewMode.allBuddies));
  }

  void _onShowAllMostEngaged(
    ShowAllMostEngaged event,
    Emitter<FemaleExploreState> emit,
  ) {
    emit(state.copyWith(viewMode: FemaleExploreViewMode.allMostEngaged));
  }

  void _onShowInitialView(
    ShowInitialView event,
    Emitter<FemaleExploreState> emit,
  ) {
    emit(state.copyWith(viewMode: FemaleExploreViewMode.initial));
  }
}


