import 'package:flutter_bloc/flutter_bloc.dart';
import 'bank_details_event.dart';
import 'bank_details_state.dart';

class BankDetailsBloc extends Bloc<BankDetailsEvent, BankDetailsState> {
  BankDetailsBloc() : super(const BankDetailsState()) {
    on<BankDetailsInitialized>(_onInitialized);
    on<AccountHolderNameChanged>(_onAccountHolderNameChanged);
    on<AccountNumberChanged>(_onAccountNumberChanged);
    on<BankNameChanged>(_onBankNameChanged);
    on<IfscCodeChanged>(_onIfscCodeChanged);
    on<UpiIdChanged>(_onUpiIdChanged);
    on<BankDetailsSubmitted>(_onSubmitted);
  }

  void _onInitialized(
    BankDetailsInitialized event,
    Emitter<BankDetailsState> emit,
  ) {
    // Initialize state
  }

  void _onAccountHolderNameChanged(
    AccountHolderNameChanged event,
    Emitter<BankDetailsState> emit,
  ) {
    emit(state.copyWith(accountHolderName: event.name));
  }

  void _onAccountNumberChanged(
    AccountNumberChanged event,
    Emitter<BankDetailsState> emit,
  ) {
    emit(state.copyWith(accountNumber: event.number));
  }

  void _onBankNameChanged(
    BankNameChanged event,
    Emitter<BankDetailsState> emit,
  ) {
    emit(state.copyWith(bankName: event.name));
  }

  void _onIfscCodeChanged(
    IfscCodeChanged event,
    Emitter<BankDetailsState> emit,
  ) {
    emit(state.copyWith(ifscCode: event.code.toUpperCase()));
  }

  void _onUpiIdChanged(
    UpiIdChanged event,
    Emitter<BankDetailsState> emit,
  ) {
    emit(state.copyWith(upiId: event.upiId));
  }

  void _onSubmitted(
    BankDetailsSubmitted event,
    Emitter<BankDetailsState> emit,
  ) {
    if (state.canContinue) {
      emit(state.copyWith(isLoading: true));
      // TODO: Submit to API
    }
  }
}

