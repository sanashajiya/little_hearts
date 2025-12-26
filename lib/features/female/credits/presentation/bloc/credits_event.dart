import 'package:equatable/equatable.dart';

abstract class CreditsEvent extends Equatable {
  const CreditsEvent();

  @override
  List<Object?> get props => [];
}

class CreditsInitialized extends CreditsEvent {
  const CreditsInitialized();
}

class TabChanged extends CreditsEvent {
  final CreditsTab tab;

  const TabChanged(this.tab);

  @override
  List<Object?> get props => [tab];
}

class DateFilterChanged extends CreditsEvent {
  final DateTime? startDate;
  final DateTime? endDate;

  const DateFilterChanged({
    this.startDate,
    this.endDate,
  });

  @override
  List<Object?> get props => [startDate, endDate];
}

class CreditsCalendarOpened extends CreditsEvent {
  const CreditsCalendarOpened();
}

class CreditsCalendarClosed extends CreditsEvent {
  const CreditsCalendarClosed();
}

class CreditsDateSelected extends CreditsEvent {
  final DateTime selectedDate;

  const CreditsDateSelected(this.selectedDate);

  @override
  List<Object?> get props => [selectedDate];
}

class CreditsMonthChanged extends CreditsEvent {
  final bool isNext;

  const CreditsMonthChanged({required this.isNext});

  @override
  List<Object?> get props => [isNext];
}

enum CreditsTab { callHistory, withdrawalHistory }

