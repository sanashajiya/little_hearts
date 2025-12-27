import 'live_room_host.dart';
import 'live_room_participant.dart';

/// Live Room Entity
class LiveRoom {
  final String id;
  final String topic;
  final bool isAudio;
  final LiveRoomHost host;
  final List<LiveRoomParticipant> participants;
  final List<String> waitlist;
  final int liveViewerCount;
  final bool isJoined;

  const LiveRoom({
    required this.id,
    required this.topic,
    required this.isAudio,
    required this.host,
    required this.participants,
    required this.waitlist,
    required this.liveViewerCount,
    this.isJoined = false,
  });
}

