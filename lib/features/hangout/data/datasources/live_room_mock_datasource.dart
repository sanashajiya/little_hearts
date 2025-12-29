import 'live_room_datasource.dart';
import '../../domain/entities/live_room.dart';
import '../../domain/entities/live_room_host.dart';
import '../../domain/entities/live_room_participant.dart';

/// Mock Data Source for Live Room
class LiveRoomMockDataSource implements LiveRoomDataSource {
  @override
  Future<LiveRoom> getLiveRoom(String roomId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));

    return LiveRoom(
      id: roomId,
      topic: 'Love', // Default topic, will be overridden by navigation params
      isAudio: true,
      host: const LiveRoomHost(
        id: 'host1',
        name: 'Meghana',
        profileImage: 'assets/images/gstar6.png',
        followerCount: 2400,
        isLive: true,
      ),
      participants: const [
        LiveRoomParticipant(
          id: 'p1',
          name: 'swapna',
          profileImage: 'assets/images/gstar2.png',
        ),
        LiveRoomParticipant(
          id: 'p2',
          name: 'Eshwar',
          profileImage: 'assets/images/gstar1.png',
        ),
        LiveRoomParticipant(
          id: 'p3',
          name: 'Harsha',
          profileImage: 'assets/images/most_engaged2.png',
        ),
      ],
      waitlist: const ['Jagadeesh', 'Rahul'],
      liveViewerCount: 1234,
      isJoined: false,
    );
  }

  @override
  Future<LiveRoom> joinLiveRoom(String roomId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final room = await getLiveRoom(roomId);
    return LiveRoom(
      id: room.id,
      topic: room.topic,
      isAudio: room.isAudio,
      host: room.host,
      participants: room.participants,
      waitlist: room.waitlist,
      liveViewerCount: room.liveViewerCount,
      isJoined: true,
    );
  }

  @override
  Future<void> sendMessage(String roomId, String message) async {
    await Future.delayed(const Duration(milliseconds: 200));
    // In real implementation, this would send message to server
  }

  @override
  Future<void> submitReport(String roomId, String reason, {String? otherReason}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    // In real implementation, this would submit report to server
  }
}


