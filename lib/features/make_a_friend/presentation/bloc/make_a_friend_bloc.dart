import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/make_a_friend_repository.dart';
import 'make_a_friend_event.dart';
import 'make_a_friend_state.dart';

class MakeAFriendBloc extends Bloc<MakeAFriendEvent, MakeAFriendState> {
  final MakeAFriendRepository repository;

  MakeAFriendBloc({required this.repository})
      : super(const MakeAFriendState()) {
    on<MakeAFriendInitialized>(_onInitialized);
    on<TabSwitched>(_onTabSwitched);
    on<RandomCallRequested>(_onRandomCallRequested);
  }

  Future<void> _onInitialized(
    MakeAFriendInitialized event,
    Emitter<MakeAFriendState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    try {
      final gIconsAvatars = await repository.getGIconsAvatars();
      final gStarsAvatars = await repository.getGStarsAvatars();
      emit(
        state.copyWith(
          gIconsAvatars: gIconsAvatars,
          gStarsAvatars: gStarsAvatars,
          isLoading: false,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to load avatars',
        ),
      );
    }
  }

  Future<void> _onTabSwitched(
    TabSwitched event,
    Emitter<MakeAFriendState> emit,
  ) async {
    emit(state.copyWith(selectedCategory: event.category));
  }

  Future<void> _onRandomCallRequested(
    RandomCallRequested event,
    Emitter<MakeAFriendState> emit,
  ) async {
    // TODO: Implement random call logic later
    // For now, just handle the event without state changes
  }
}

