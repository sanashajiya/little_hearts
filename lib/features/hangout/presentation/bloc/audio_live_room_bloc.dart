import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/live_room_repository.dart';
import 'audio_live_room_event.dart';
import 'audio_live_room_state.dart';
import '../../domain/entities/live_room.dart';

/// Audio Live Room Bloc
class AudioLiveRoomBloc extends Bloc<AudioLiveRoomEvent, AudioLiveRoomState> {
  final LiveRoomRepository _repository;
  String? _currentRoomId;

  AudioLiveRoomBloc({required LiveRoomRepository repository})
      : _repository = repository,
        super(const LiveRoomInitial()) {
    on<LoadLiveRoom>(_onLoadLiveRoom);
    on<JoinRoom>(_onJoinRoom);
    on<SendMessage>(_onSendMessage);
    on<OpenReport>(_onOpenReport);
    on<SubmitReport>(_onSubmitReport);
    on<CancelReport>(_onCancelReport);
  }

  Future<void> _onLoadLiveRoom(
    LoadLiveRoom event,
    Emitter<AudioLiveRoomState> emit,
  ) async {
    _currentRoomId = event.roomId;
    emit(const LiveRoomLoading());
    try {
      final room = await _repository.getLiveRoom(event.roomId);
      // Update topic from navigation params
      final updatedRoom = LiveRoom(
        id: room.id,
        topic: event.topic,
        isAudio: room.isAudio,
        host: room.host,
        participants: room.participants,
        waitlist: room.waitlist,
        liveViewerCount: room.liveViewerCount,
        isJoined: room.isJoined,
      );
      emit(LiveRoomLoaded(room: updatedRoom));
    } catch (e) {
      emit(LiveRoomError(message: e.toString()));
    }
  }

  Future<void> _onJoinRoom(
    JoinRoom event,
    Emitter<AudioLiveRoomState> emit,
  ) async {
    if (_currentRoomId == null) return;

    final currentState = state;
    if (currentState is LiveRoomLoaded) {
      try {
        final room = await _repository.joinLiveRoom(_currentRoomId!);
        emit(LiveRoomJoined(room: room));
      } catch (e) {
        emit(LiveRoomError(message: e.toString()));
      }
    }
  }

  Future<void> _onSendMessage(
    SendMessage event,
    Emitter<AudioLiveRoomState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      await _repository.sendMessage(_currentRoomId!, event.message);
      // Message sent successfully, state remains the same
    } catch (e) {
      emit(LiveRoomError(message: e.toString()));
    }
  }

  void _onOpenReport(
    OpenReport event,
    Emitter<AudioLiveRoomState> emit,
  ) {
    final currentState = state;
    if (currentState is LiveRoomLoaded) {
      emit(ReportBottomSheetState(room: currentState.room));
    } else if (currentState is LiveRoomJoined) {
      emit(ReportBottomSheetState(room: currentState.room));
    }
  }

  Future<void> _onSubmitReport(
    SubmitReport event,
    Emitter<AudioLiveRoomState> emit,
  ) async {
    if (_currentRoomId == null) return;

    try {
      await _repository.submitReport(
        _currentRoomId!,
        event.reason,
        otherReason: event.otherReason,
      );
      // After submitting, restore to previous state
      final currentState = state;
      if (currentState is ReportBottomSheetState) {
        if (currentState.room.isJoined) {
          emit(LiveRoomJoined(room: currentState.room));
        } else {
          emit(LiveRoomLoaded(room: currentState.room));
        }
      }
    } catch (e) {
      emit(LiveRoomError(message: e.toString()));
    }
  }

  void _onCancelReport(
    CancelReport event,
    Emitter<AudioLiveRoomState> emit,
  ) {
    // Restore to previous state when canceling
    final currentState = state;
    if (currentState is ReportBottomSheetState) {
      if (currentState.room.isJoined) {
        emit(LiveRoomJoined(room: currentState.room));
      } else {
        emit(LiveRoomLoaded(room: currentState.room));
      }
    }
  }
}

