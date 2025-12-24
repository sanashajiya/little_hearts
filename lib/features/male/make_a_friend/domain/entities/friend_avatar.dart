enum FriendCategory {
  gicons,
  gstars,
}

class FriendAvatar {
  final String imageAsset;
  final bool isOnline;

  const FriendAvatar({
    required this.imageAsset,
    this.isOnline = true,
  });
}

