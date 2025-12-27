import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/hangout_repository.dart';
import 'hangout_event.dart';
import 'hangout_state.dart';

/// Hangout Bloc
class HangoutBloc extends Bloc<HangoutEvent, HangoutState> {
  final HangoutRepository _repository;

  HangoutBloc({required HangoutRepository repository})
      : _repository = repository,
        super(const HangoutInitial()) {
    on<LoadHangoutUsers>(_onLoadHangoutUsers);
    on<SwitchHangoutTab>(_onSwitchHangoutTab);
    on<SearchHangoutUser>(_onSearchHangoutUser);
    on<SelectHangoutZone>(_onSelectHangoutZone);
    on<UpdateHangoutTopic>(_onUpdateHangoutTopic);
    on<CreateHangout>(_onCreateHangout);
  }

  Future<void> _onLoadHangoutUsers(
    LoadHangoutUsers event,
    Emitter<HangoutState> emit,
  ) async {
    emit(const HangoutLoading());
    try {
      final users = await _repository.getHangoutUsers(isAudio: event.isAudio);
      emit(HangoutLoaded(users: users, isAudio: event.isAudio));
    } catch (e) {
      emit(HangoutError(message: e.toString()));
    }
  }

  Future<void> _onSwitchHangoutTab(
    SwitchHangoutTab event,
    Emitter<HangoutState> emit,
  ) async {
    emit(const HangoutLoading());
    try {
      final users = await _repository.getHangoutUsers(isAudio: event.isAudio);
      emit(HangoutLoaded(users: users, isAudio: event.isAudio));
    } catch (e) {
      emit(HangoutError(message: e.toString()));
    }
  }

  Future<void> _onSearchHangoutUser(
    SearchHangoutUser event,
    Emitter<HangoutState> emit,
  ) async {
    if (event.query.isEmpty) {
      // If search is empty, reload all users
      add(LoadHangoutUsers(isAudio: event.isAudio));
      return;
    }

    emit(const HangoutLoading());
    try {
      final users = await _repository.searchHangoutUsers(
        event.query,
        isAudio: event.isAudio,
      );
      emit(HangoutLoaded(
        users: users,
        isAudio: event.isAudio,
        searchQuery: event.query,
      ));
    } catch (e) {
      emit(HangoutError(message: e.toString()));
    }
  }

  void _onSelectHangoutZone(
    SelectHangoutZone event,
    Emitter<HangoutState> emit,
  ) {
    final currentState = state;
    if (currentState is CreateHangoutState) {
      emit(CreateHangoutState(
        selectedZone: event.isAudio,
        topic: currentState.topic,
      ));
    } else {
      emit(CreateHangoutState(selectedZone: event.isAudio));
    }
  }

  void _onUpdateHangoutTopic(
    UpdateHangoutTopic event,
    Emitter<HangoutState> emit,
  ) {
    final currentState = state;
    if (currentState is CreateHangoutState) {
      emit(CreateHangoutState(
        selectedZone: currentState.selectedZone,
        topic: event.topic,
      ));
    } else {
      emit(CreateHangoutState(topic: event.topic));
    }
  }

  void _onCreateHangout(
    CreateHangout event,
    Emitter<HangoutState> emit,
  ) {
    // Emit state with room creation info - navigation will handle routing
    emit(const CreateHangoutState());
  }
}

