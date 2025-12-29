import 'package:equatable/equatable.dart';

abstract class BankDetailsEvent extends Equatable {
  const BankDetailsEvent();

  @override
  List<Object?> get props => [];
}

class BankDetailsInitialized extends BankDetailsEvent {
  const BankDetailsInitialized();
}

class AccountHolderNameChanged extends BankDetailsEvent {
  final String name;

  const AccountHolderNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class AccountNumberChanged extends BankDetailsEvent {
  final String number;

  const AccountNumberChanged(this.number);

  @override
  List<Object?> get props => [number];
}

class BankNameChanged extends BankDetailsEvent {
  final String name;

  const BankNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

class IfscCodeChanged extends BankDetailsEvent {
  final String code;

  const IfscCodeChanged(this.code);

  @override
  List<Object?> get props => [code];
}

class UpiIdChanged extends BankDetailsEvent {
  final String upiId;

  const UpiIdChanged(this.upiId);

  @override
  List<Object?> get props => [upiId];
}

class BankDetailsSubmitted extends BankDetailsEvent {
  const BankDetailsSubmitted();
}



