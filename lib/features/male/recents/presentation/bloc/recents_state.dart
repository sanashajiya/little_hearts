import 'package:equatable/equatable.dart';

import '../../domain/entities/call_record.dart';
import '../../domain/entities/transaction_record.dart';
import 'recents_event.dart';

class RecentsState extends Equatable {
  final RecentsTab selectedTab;
  final bool isLoading;
  final bool isCalendarVisible;
  final DateTime currentMonth;
  final DateTime? selectedDate;
  final List<TransactionRecord> transactions;
  final List<CallRecord> calls;

  RecentsState({
    this.selectedTab = RecentsTab.transactions,
    this.isLoading = false,
    this.isCalendarVisible = false,
    DateTime? currentMonth,
    this.selectedDate,
    this.transactions = const [],
    this.calls = const [],
  }) : currentMonth = currentMonth ??  DateTime(2025, 12, 1);

  RecentsState copyWith({
    RecentsTab? selectedTab,
    bool? isLoading,
    bool? isCalendarVisible,
    DateTime? currentMonth,
    DateTime? selectedDate,
    List<TransactionRecord>? transactions,
    List<CallRecord>? calls,
  }) {
    return RecentsState(
      selectedTab: selectedTab ?? this.selectedTab,
      isLoading: isLoading ?? this.isLoading,
      isCalendarVisible: isCalendarVisible ?? this.isCalendarVisible,
      currentMonth: currentMonth ?? this.currentMonth,
      selectedDate: selectedDate ?? this.selectedDate,
      transactions: transactions ?? this.transactions,
      calls: calls ?? this.calls,
    );
  }

  @override
  List<Object?> get props => [
        selectedTab,
        isLoading,
        isCalendarVisible,
        currentMonth,
        selectedDate,
        transactions,
        calls,
      ];
}


