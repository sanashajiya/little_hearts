class LeaderboardEntry {
  final int rank;
  final String userId;
  final String name;
  final String profileImage;
  final int score;
  final bool isMale;

  const LeaderboardEntry({
    required this.rank,
    required this.userId,
    required this.name,
    required this.profileImage,
    required this.score,
    required this.isMale,
  });
}

