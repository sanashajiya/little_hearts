import '../entities/leaderboard_entry.dart';
import '../entities/leaderboard_type.dart';
import '../entities/leaderboard_zone.dart';
import '../repositories/leaderboard_repository.dart';

class GetLeaderboard {
  final LeaderboardRepository repository;

  GetLeaderboard(this.repository);

  Future<List<LeaderboardEntry>> call({
    required LeaderboardZone zone,
    required LeaderboardType type,
  }) async {
    return await repository.getLeaderboard(zone: zone, type: type);
  }
}


