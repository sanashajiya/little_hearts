import 'package:equatable/equatable.dart';
import '../../domain/entities/leaderboard_type.dart';
import '../../domain/entities/leaderboard_zone.dart';

abstract class LeaderboardEvent extends Equatable {
  const LeaderboardEvent();

  @override
  List<Object?> get props => [];
}

class LoadLeaderboard extends LeaderboardEvent {
  final LeaderboardZone zone;
  final LeaderboardType type;

  const LoadLeaderboard({
    required this.zone,
    required this.type,
  });

  @override
  List<Object?> get props => [zone, type];
}

class ChangeZone extends LeaderboardEvent {
  final LeaderboardZone zone;

  const ChangeZone(this.zone);

  @override
  List<Object?> get props => [zone];
}

class ChangeLeaderboardType extends LeaderboardEvent {
  final LeaderboardType type;

  const ChangeLeaderboardType(this.type);

  @override
  List<Object?> get props => [type];
}

