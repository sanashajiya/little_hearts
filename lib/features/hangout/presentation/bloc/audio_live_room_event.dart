import 'package:equatable/equatable.dart';

/// Audio Live Room Events
abstract class AudioLiveRoomEvent extends Equatable {
  const AudioLiveRoomEvent();

  @override
  List<Object?> get props => [];
}

/// Load live room
class LoadLiveRoom extends AudioLiveRoomEvent {
  final String roomId;
  final String topic;

  const LoadLiveRoom({required this.roomId, required this.topic});

  @override
  List<Object?> get props => [roomId, topic];
}

/// Join live room
class JoinRoom extends AudioLiveRoomEvent {
  const JoinRoom();
}

/// Send message in live room
class SendMessage extends AudioLiveRoomEvent {
  final String message;

  const SendMessage({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Open report bottom sheet
class OpenReport extends AudioLiveRoomEvent {
  const OpenReport();
}

/// Submit report
class SubmitReport extends AudioLiveRoomEvent {
  final String reason;
  final String? otherReason;

  const SubmitReport({required this.reason, this.otherReason});

  @override
  List<Object?> get props => [reason, otherReason];
}

/// Cancel report
class CancelReport extends AudioLiveRoomEvent {
  const CancelReport();
}


