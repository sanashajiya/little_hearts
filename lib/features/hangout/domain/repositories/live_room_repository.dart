import '../entities/live_room.dart';

/// Live Room Repository Interface
abstract class LiveRoomRepository {
  /// Get live room by ID
  Future<LiveRoom> getLiveRoom(String roomId);

  /// Join a live room
  Future<LiveRoom> joinLiveRoom(String roomId);

  /// Send a message in live room
  Future<void> sendMessage(String roomId, String message);

  /// Submit a report
  Future<void> submitReport(String roomId, String reason, {String? otherReason});
}

