import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/leaderboard_repository_impl.dart';
import '../../domain/entities/leaderboard_type.dart';
import '../../domain/entities/leaderboard_zone.dart';
import '../../domain/usecases/get_leaderboard.dart';
import 'leaderboard_event.dart';
import 'leaderboard_state.dart';

class LeaderboardBloc extends Bloc<LeaderboardEvent, LeaderboardState> {
  final GetLeaderboard getLeaderboard;

  LeaderboardBloc({GetLeaderboard? getLeaderboard})
      : getLeaderboard = getLeaderboard ??
            GetLeaderboard(LeaderboardRepositoryImpl()),
        super(const LeaderboardInitial()) {
    on<LoadLeaderboard>(_onLoadLeaderboard);
    on<ChangeZone>(_onChangeZone);
    on<ChangeLeaderboardType>(_onChangeLeaderboardType);
  }

  Future<void> _onLoadLeaderboard(
    LoadLeaderboard event,
    Emitter<LeaderboardState> emit,
  ) async {
    emit(const LeaderboardLoading());

    try {
      final entries = await getLeaderboard.call(
        zone: event.zone,
        type: event.type,
      );

      final topThree = entries.take(3).toList();
      final rest = entries.skip(3).toList();

      emit(LeaderboardLoaded(
        zone: event.zone,
        type: event.type,
        entries: entries,
        topThree: topThree,
        rest: rest,
      ));
    } catch (e) {
      emit(LeaderboardError(e.toString()));
    }
  }

  Future<void> _onChangeZone(
    ChangeZone event,
    Emitter<LeaderboardState> emit,
  ) async {
    final currentState = state;
    if (currentState is LeaderboardLoaded) {
      add(LoadLeaderboard(
        zone: event.zone,
        type: currentState.type,
      ));
    } else {
      add(LoadLeaderboard(
        zone: event.zone,
        type: LeaderboardType.topEarner,
      ));
    }
  }

  Future<void> _onChangeLeaderboardType(
    ChangeLeaderboardType event,
    Emitter<LeaderboardState> emit,
  ) async {
    final currentState = state;
    if (currentState is LeaderboardLoaded) {
      add(LoadLeaderboard(
        zone: currentState.zone,
        type: event.type,
      ));
    } else {
      add(LoadLeaderboard(
        zone: LeaderboardZone.friend,
        type: event.type,
      ));
    }
  }
}

