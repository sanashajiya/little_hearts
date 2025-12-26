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

enum CreditsTab { callHistory, withdrawalHistory }

