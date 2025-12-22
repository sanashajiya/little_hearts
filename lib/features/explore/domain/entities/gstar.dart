import 'gicon.dart';

class GStar {
  final String name;
  final int age;
  final String location;
  final String imageAsset;
  final bool isOnline;
  final CallType callType;

  const GStar({
    required this.name,
    required this.age,
    required this.location,
    required this.imageAsset,
    this.isOnline = true,
    this.callType = CallType.audio,
  });
}


