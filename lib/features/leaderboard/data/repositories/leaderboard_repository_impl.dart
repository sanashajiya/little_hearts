import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/leaderboard_type.dart';
import '../../domain/entities/leaderboard_zone.dart';
import '../../domain/repositories/leaderboard_repository.dart';

class LeaderboardRepositoryImpl implements LeaderboardRepository {
  @override
  Future<List<LeaderboardEntry>> getLeaderboard({
    required LeaderboardZone zone,
    required LeaderboardType type,
  }) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final allEntries = _generateMockData(type);

    // Apply gender-based filtering rules
    List<LeaderboardEntry> filtered = _applyGenderRules(
      allEntries,
      zone: zone,
      type: type,
    );

    // Sort by score (descending)
    filtered.sort((a, b) => b.score.compareTo(a.score));

    // Reassign ranks
    for (int i = 0; i < filtered.length; i++) {
      filtered[i] = LeaderboardEntry(
        rank: i + 1,
        userId: filtered[i].userId,
        name: filtered[i].name,
        profileImage: filtered[i].profileImage,
        score: filtered[i].score,
        isMale: filtered[i].isMale,
      );
    }

    return filtered;
  }

  List<LeaderboardEntry> _generateMockData(LeaderboardType type) {
    // Top Earner mock data
    final topEarners = [
      // Females
      const LeaderboardEntry(
        rank: 1,
        userId: '1',
        name: 'Sophie',
        profileImage: 'assets/images/gicon1.png',
        score: 1500,
        isMale: false,
      ),
      const LeaderboardEntry(
        rank: 2,
        userId: '2',
        name: 'Emma',
        profileImage: 'assets/images/gicon4.png',
        score: 1000,
        isMale: false,
      ),
      const LeaderboardEntry(
        rank: 3,
        userId: '3',
        name: 'Aria',
        profileImage: 'assets/images/gicon3.png',
        score: 900,
        isMale: false,
      ),
      const LeaderboardEntry(
        rank: 4,
        userId: '4',
        name: 'Luna',
        profileImage: 'assets/images/gicon2.png',
        score: 800,
        isMale: false,
      ),
      const LeaderboardEntry(
        rank: 5,
        userId: '5',
        name: 'Zoe',
        profileImage: 'assets/images/gicon1.png',
        score: 650,
        isMale: false,
      ),
      const LeaderboardEntry(
        rank: 6,
        userId: '6',
        name: 'Maya',
        profileImage: 'assets/images/gicon6.png',
        score: 503,
        isMale: false,
      ),
      const LeaderboardEntry(
        rank: 7,
        userId: '7',
        name: 'Ivy',
        profileImage: 'assets/images/gicon7.png',
        score: 490,
        isMale: false,
      ),
      const LeaderboardEntry(
        rank: 8,
        userId: '8',
        name: 'Samantha',
        profileImage: 'assets/images/gicon8.png',
        score: 400,
        isMale: false,
      ),
      const LeaderboardEntry(
        rank: 9,
        userId: '9',
        name: 'Riya',
        profileImage: 'assets/images/gicon2.png',
        score: 370,
        isMale: false,
      ),
      const LeaderboardEntry(
        rank: 10,
        userId: '10',
        name: 'Divya',
        profileImage: 'assets/images/gicon4.png',
        score: 300,
        isMale: false,
      ),
      // Males (for Hangout Zone)
      const LeaderboardEntry(
        rank: 11,
        userId: '21',
        name: 'John',
        profileImage: 'assets/images/buddy1.png',
        score: 750,
        isMale: true,
      ),
      const LeaderboardEntry(
        rank: 12,
        userId: '22',
        name: 'Mike',
        profileImage: 'assets/images/buddy2.png',
        score: 600,
        isMale: true,
      ),
    ];

    // Top Gifter mock data
    final topGifters = [
      // Males
      const LeaderboardEntry(
        rank: 1,
        userId: '31',
        name: 'Sandesh',
        profileImage: 'assets/images/buddy3.png',
        score: 500,
        isMale: true,
      ),
      const LeaderboardEntry(
        rank: 2,
        userId: '32',
        name: 'Emmanuel',
        profileImage: 'assets/images/buddy4.png',
        score: 80,
        isMale: true,
      ),
      const LeaderboardEntry(
        rank: 3,
        userId: '33',
        name: 'Arya',
        profileImage: 'assets/images/buddy5.png',
        score: 90,
        isMale: true,
      ),
      const LeaderboardEntry(
        rank: 4,
        userId: '34',
        name: 'Vijay',
        profileImage: 'assets/images/buddy6.png',
        score: 100,
        isMale: true,
      ),
      const LeaderboardEntry(
        rank: 5,
        userId: '35',
        name: 'Zoe',
        profileImage: 'assets/images/buddy7.png',
        score: 100,
        isMale: true,
      ),
      const LeaderboardEntry(
        rank: 6,
        userId: '36',
        name: 'Mallesh',
        profileImage: 'assets/images/buddy8.png',
        score: 100,
        isMale: true,
      ),
      const LeaderboardEntry(
        rank: 7,
        userId: '37',
        name: 'Rajesh',
        profileImage: 'assets/images/story1.png',
        score: 100,
        isMale: true,
      ),
      const LeaderboardEntry(
        rank: 8,
        userId: '38',
        name: 'Sumantha',
        profileImage: 'assets/images/story2.png',
        score: 100,
        isMale: true,
      ),
      const LeaderboardEntry(
        rank: 9,
        userId: '39',
        name: 'Riyaj',
        profileImage: 'assets/images/story3.png',
        score: 100,
        isMale: true,
      ),
      const LeaderboardEntry(
        rank: 10,
        userId: '40',
        name: 'Divyansh',
        profileImage: 'assets/images/story4.png',
        score: 100,
        isMale: true,
      ),
      // Females (for Hangout Zone)
      const LeaderboardEntry(
        rank: 11,
        userId: '41',
        name: 'Sarah',
        profileImage: 'assets/images/gicon2.png',
        score: 85,
        isMale: false,
      ),
      const LeaderboardEntry(
        rank: 12,
        userId: '42',
        name: 'Lisa',
        profileImage: 'assets/images/gicon1.png',
        score: 70,
        isMale: false,
      ),
    ];

    // Return appropriate list based on type (we'll filter in _applyGenderRules)
    return type == LeaderboardType.topEarner ? topEarners : topGifters;
  }

  List<LeaderboardEntry> _applyGenderRules(
    List<LeaderboardEntry> entries, {
    required LeaderboardZone zone,
    required LeaderboardType type,
  }) {
    switch (zone) {
      case LeaderboardZone.friend:
      case LeaderboardZone.date:
        // Friend Zone & Date Mode: Same rules
        if (type == LeaderboardType.topEarner) {
          // Only Female profiles
          return entries.where((e) => !e.isMale).toList();
        } else {
          // Only Male profiles
          return entries.where((e) => e.isMale).toList();
        }

      case LeaderboardZone.hangout:
        // Hangout Zone: Both Male & Female profiles
        return entries;
    }
  }
}

