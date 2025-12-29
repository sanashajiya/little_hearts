import '../entities/leaderboard_entry.dart';
import '../entities/leaderboard_type.dart';
import '../entities/leaderboard_zone.dart';

abstract class LeaderboardRepository {
  Future<List<LeaderboardEntry>> getLeaderboard({
    required LeaderboardZone zone,
    required LeaderboardType type,
  });
}


