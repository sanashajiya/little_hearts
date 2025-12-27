import 'package:equatable/equatable.dart';
import '../../domain/entities/leaderboard_entry.dart';
import '../../domain/entities/leaderboard_type.dart';
import '../../domain/entities/leaderboard_zone.dart';

abstract class LeaderboardState extends Equatable {
  const LeaderboardState();

  @override
  List<Object?> get props => [];
}

class LeaderboardInitial extends LeaderboardState {
  const LeaderboardInitial();
}

class LeaderboardLoading extends LeaderboardState {
  const LeaderboardLoading();
}

class LeaderboardLoaded extends LeaderboardState {
  final LeaderboardZone zone;
  final LeaderboardType type;
  final List<LeaderboardEntry> entries;
  final List<LeaderboardEntry> topThree;
  final List<LeaderboardEntry> rest;

  const LeaderboardLoaded({
    required this.zone,
    required this.type,
    required this.entries,
    required this.topThree,
    required this.rest,
  });

  @override
  List<Object?> get props => [zone, type, entries, topThree, rest];
}

class LeaderboardError extends LeaderboardState {
  final String message;

  const LeaderboardError(this.message);

  @override
  List<Object?> get props => [message];
}

