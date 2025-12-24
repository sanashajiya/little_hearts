import 'package:equatable/equatable.dart';

import '../../domain/entities/call_record.dart';

enum RecentsTab { transactions, calls }

abstract class RecentsEvent extends Equatable {
  const RecentsEvent();

  @override
  List<Object?> get props => [];
}

class RecentsInitialized extends RecentsEvent {
  const RecentsInitialized();
}

class RecentsTabChanged extends RecentsEvent {
  final RecentsTab tab;

  const RecentsTabChanged(this.tab);

  @override
  List<Object?> get props => [tab];
}

class RecentsCalendarOpened extends RecentsEvent {
  const RecentsCalendarOpened();
}

class RecentsCalendarClosed extends RecentsEvent {
  const RecentsCalendarClosed();
}

class RecentsDateSelected extends RecentsEvent {
  final DateTime selectedDate;

  const RecentsDateSelected(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}

class RecentsMonthChanged extends RecentsEvent {
  final bool isNext;

  const RecentsMonthChanged({required this.isNext});

  @override
  List<Object?> get props => [isNext];
}

class RecentsCallDatesLoaded extends RecentsEvent {
  final List<CallRecord> calls;

  const RecentsCallDatesLoaded(this.calls);

  @override
  List<Object?> get props => [calls];
}
