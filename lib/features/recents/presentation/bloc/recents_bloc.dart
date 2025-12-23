import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/recents_repository.dart';
import '../../domain/entities/call_record.dart';
import '../../domain/entities/transaction_record.dart';
import 'recents_event.dart';
import 'recents_state.dart';

class RecentsBloc extends Bloc<RecentsEvent, RecentsState> {
  final RecentsRepository repository;

  RecentsBloc({required this.repository}) : super(RecentsState()) {
    on<RecentsInitialized>(_onInitialized);
    on<RecentsTabChanged>(_onTabChanged);
    on<RecentsCalendarOpened>(_onCalendarOpened);
    on<RecentsCalendarClosed>(_onCalendarClosed);
    on<RecentsDateSelected>(_onDateSelected);
    on<RecentsMonthChanged>(_onMonthChanged);
  }

  Future<void> _onInitialized(
    RecentsInitialized event,
    Emitter<RecentsState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final List<TransactionRecord> transactions = await repository
        .getTransactionHistory();
    final List<CallRecord> calls = await repository.getCallHistory();
    emit(
      state.copyWith(
        isLoading: false,
        transactions: transactions,
        calls: calls,
      ),
    );
  }

  void _onTabChanged(RecentsTabChanged event, Emitter<RecentsState> emit) {
    emit(state.copyWith(selectedTab: event.tab));
  }

  void _onCalendarOpened(
    RecentsCalendarOpened event,
    Emitter<RecentsState> emit,
  ) {
    emit(state.copyWith(isCalendarVisible: true));
  }

  void _onCalendarClosed(
    RecentsCalendarClosed event,
    Emitter<RecentsState> emit,
  ) {
    emit(state.copyWith(isCalendarVisible: false));
  }

  void _onDateSelected(RecentsDateSelected event, Emitter<RecentsState> emit) {
    emit(state.copyWith(selectedDate: event.selectedDate));
  }

  void _onMonthChanged(RecentsMonthChanged event, Emitter<RecentsState> emit) {
    final current = state.currentMonth;
    final nextMonth = DateTime(
      current.year,
      current.month + (event.isNext ? 1 : -1),
      1,
    );
    emit(state.copyWith(currentMonth: nextMonth));
  }
}
