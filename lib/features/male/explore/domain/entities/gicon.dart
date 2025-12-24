enum CallType {
  audio,
  video,
}

enum UserStatus {
  online,
  offline,
  busy,
}

class GIcon {
  final String name;
  final int age;
  final String location;
  final String imageAsset;
  final UserStatus status;
  final CallType callType;

  const GIcon({
    required this.name,
    required this.age,
    required this.location,
    required this.imageAsset,
    this.status = UserStatus.online,
    this.callType = CallType.audio,
  });
}


