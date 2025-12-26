import 'package:equatable/equatable.dart';
import '../../domain/entities/call_history_item.dart';
import '../../domain/entities/withdrawal_history_item.dart';
import 'credits_event.dart';

class CreditsState extends Equatable {
  final int totalStars;
  final CreditsTab selectedTab;
  final List<CallHistoryItem> callHistory;
  final List<WithdrawalHistoryItem> withdrawalHistory;
  final DateTime? filterStartDate;
  final DateTime? filterEndDate;
  final bool isCalendarVisible;
  final DateTime currentMonth;
  final DateTime? selectedDate;

  CreditsState({
    this.totalStars = 0,
    this.selectedTab = CreditsTab.callHistory,
    this.callHistory = const [],
    this.withdrawalHistory = const [],
    this.filterStartDate,
    this.filterEndDate,
    this.isCalendarVisible = false,
    DateTime? currentMonth,
    this.selectedDate,
  }) : currentMonth = currentMonth ?? DateTime.now();

  int get convertedAmount => totalStars; // 1 Star = 1 Rupee

  List<CallHistoryItem> get filteredCallHistory {
    if (filterStartDate == null && filterEndDate == null) {
      return callHistory;
    }
    return callHistory.where((item) {
      if (filterStartDate != null && item.dateTime.isBefore(filterStartDate!)) {
        return false;
      }
      if (filterEndDate != null && item.dateTime.isAfter(filterEndDate!)) {
        return false;
      }
      return true;
    }).toList();
  }

  List<WithdrawalHistoryItem> get filteredWithdrawalHistory {
    if (filterStartDate == null && filterEndDate == null) {
      return withdrawalHistory;
    }
    return withdrawalHistory.where((item) {
      if (filterStartDate != null && item.dateTime.isBefore(filterStartDate!)) {
        return false;
      }
      if (filterEndDate != null && item.dateTime.isAfter(filterEndDate!)) {
        return false;
      }
      return true;
    }).toList();
  }

  CreditsState copyWith({
    int? totalStars,
    CreditsTab? selectedTab,
    List<CallHistoryItem>? callHistory,
    List<WithdrawalHistoryItem>? withdrawalHistory,
    DateTime? filterStartDate,
    DateTime? filterEndDate,
    bool? isCalendarVisible,
    DateTime? currentMonth,
    DateTime? selectedDate,
  }) {
    return CreditsState(
      totalStars: totalStars ?? this.totalStars,
      selectedTab: selectedTab ?? this.selectedTab,
      callHistory: callHistory ?? this.callHistory,
      withdrawalHistory: withdrawalHistory ?? this.withdrawalHistory,
      filterStartDate: filterStartDate ?? this.filterStartDate,
      filterEndDate: filterEndDate ?? this.filterEndDate,
      isCalendarVisible: isCalendarVisible ?? this.isCalendarVisible,
      currentMonth: currentMonth ?? this.currentMonth,
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }

  @override
  List<Object?> get props => [
        totalStars,
        selectedTab,
        callHistory,
        withdrawalHistory,
        filterStartDate,
        filterEndDate,
        isCalendarVisible,
        currentMonth,
        selectedDate,
      ];
}

