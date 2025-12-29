import 'package:equatable/equatable.dart';
import '../../domain/entities/live_room.dart';

/// Audio Live Room States
abstract class AudioLiveRoomState extends Equatable {
  const AudioLiveRoomState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class LiveRoomInitial extends AudioLiveRoomState {
  const LiveRoomInitial();
}

/// Loading state
class LiveRoomLoading extends AudioLiveRoomState {
  const LiveRoomLoading();
}

/// Loaded state with room data
class LiveRoomLoaded extends AudioLiveRoomState {
  final LiveRoom room;

  const LiveRoomLoaded({required this.room});

  @override
  List<Object?> get props => [room];
}

/// Joined state
class LiveRoomJoined extends AudioLiveRoomState {
  final LiveRoom room;

  const LiveRoomJoined({required this.room});

  @override
  List<Object?> get props => [room];
}

/// Error state
class LiveRoomError extends AudioLiveRoomState {
  final String message;

  const LiveRoomError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Report bottom sheet state
class ReportBottomSheetState extends AudioLiveRoomState {
  final LiveRoom room;

  const ReportBottomSheetState({required this.room});

  @override
  List<Object?> get props => [room];
}


