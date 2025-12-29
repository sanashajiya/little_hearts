import '../../domain/entities/live_room.dart';

/// Live Room Data Source Interface
abstract class LiveRoomDataSource {
  Future<LiveRoom> getLiveRoom(String roomId);
  Future<LiveRoom> joinLiveRoom(String roomId);
  Future<void> sendMessage(String roomId, String message);
  Future<void> submitReport(String roomId, String reason, {String? otherReason});
}


