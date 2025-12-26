import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/call_history_item.dart';
import '../../domain/entities/withdrawal_history_item.dart';
import 'credits_event.dart';
import 'credits_state.dart';

class CreditsBloc extends Bloc<CreditsEvent, CreditsState> {
  CreditsBloc() : super(const CreditsState()) {
    on<CreditsInitialized>(_onInitialized);
    on<TabChanged>(_onTabChanged);
    on<DateFilterChanged>(_onDateFilterChanged);
  }

  void _onInitialized(
    CreditsInitialized event,
    Emitter<CreditsState> emit,
  ) {
    // Mock data - replace with actual API calls
    final callHistory = [
      CallHistoryItem(
        callType: 'Video',
        userName: 'Vijay',
        dateTime: DateTime.now(),
        starsEarned: 100,
      ),
      CallHistoryItem(
        callType: 'Audio',
        userName: 'Nazeer',
        dateTime: DateTime(2025, 12, 12, 11, 20),
        starsEarned: 40,
      ),
      CallHistoryItem(
        callType: 'Video',
        userName: 'Daniel',
        dateTime: DateTime(2025, 12, 16, 12, 20),
        starsEarned: 50,
      ),
      CallHistoryItem(
        callType: 'Audio',
        userName: 'Sanjay',
        dateTime: DateTime(2025, 10, 18, 11, 20),
        starsEarned: 100,
      ),
    ];

    final withdrawalHistory = [
      WithdrawalHistoryItem(
        dateTime: DateTime.now(),
        transactionId: '552463759864',
        amount: 100,
      ),
      WithdrawalHistoryItem(
        dateTime: DateTime(2025, 10, 10, 22, 20),
        transactionId: '76578539878',
        amount: 500,
      ),
      WithdrawalHistoryItem(
        dateTime: DateTime(2025, 12, 12, 11, 20),
        transactionId: '552463759864',
        amount: 400,
      ),
    ];

    final totalStars = callHistory.fold<int>(
      0,
      (sum, item) => sum + item.starsEarned,
    ) - withdrawalHistory.fold<int>(
      0,
      (sum, item) => sum + item.amount,
    );

    emit(state.copyWith(
      totalStars: totalStars,
      callHistory: callHistory,
      withdrawalHistory: withdrawalHistory,
    ));
  }

  void _onTabChanged(
    TabChanged event,
    Emitter<CreditsState> emit,
  ) {
    emit(state.copyWith(selectedTab: event.tab));
  }

  void _onDateFilterChanged(
    DateFilterChanged event,
    Emitter<CreditsState> emit,
  ) {
    emit(state.copyWith(
      filterStartDate: event.startDate,
      filterEndDate: event.endDate,
    ));
  }
}

