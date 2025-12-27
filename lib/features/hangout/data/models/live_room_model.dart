import '../../domain/entities/live_room.dart';

/// Live Room Model (Data Layer)
class LiveRoomModel extends LiveRoom {
  const LiveRoomModel({
    required super.id,
    required super.topic,
    required super.isAudio,
    required super.host,
    required super.participants,
    required super.waitlist,
    required super.liveViewerCount,
    super.isJoined,
  });

  factory LiveRoomModel.fromEntity(LiveRoom room) {
    return LiveRoomModel(
      id: room.id,
      topic: room.topic,
      isAudio: room.isAudio,
      host: room.host,
      participants: room.participants,
      waitlist: room.waitlist,
      liveViewerCount: room.liveViewerCount,
      isJoined: room.isJoined,
    );
  }
}

