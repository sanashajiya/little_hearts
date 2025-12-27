/// Live Room Host Entity
class LiveRoomHost {
  final String id;
  final String name;
  final String profileImage;
  final int followerCount;
  final bool isLive;

  const LiveRoomHost({
    required this.id,
    required this.name,
    required this.profileImage,
    required this.followerCount,
    this.isLive = true,
  });
}

