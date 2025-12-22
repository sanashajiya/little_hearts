class GIcon {
  final String name;
  final int age;
  final String location;
  final String imageAsset;
  final bool isOnline;

  const GIcon({
    required this.name,
    required this.age,
    required this.location,
    required this.imageAsset,
    this.isOnline = true,
  });
}


