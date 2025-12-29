import 'package:equatable/equatable.dart';

class BankDetailsState extends Equatable {
  final String accountHolderName;
  final String accountNumber;
  final String bankName;
  final String ifscCode;
  final String upiId;
  final bool isLoading;

  const BankDetailsState({
    this.accountHolderName = '',
    this.accountNumber = '',
    this.bankName = '',
    this.ifscCode = '',
    this.upiId = '',
    this.isLoading = false,
  });

  bool get hasBankDetails =>
      accountHolderName.isNotEmpty &&
      accountNumber.isNotEmpty &&
      bankName.isNotEmpty &&
      ifscCode.isNotEmpty;

  bool get hasUpiId => upiId.isNotEmpty;

  bool get canContinue => hasBankDetails || hasUpiId;

  BankDetailsState copyWith({
    String? accountHolderName,
    String? accountNumber,
    String? bankName,
    String? ifscCode,
    String? upiId,
    bool? isLoading,
  }) {
    return BankDetailsState(
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountNumber: accountNumber ?? this.accountNumber,
      bankName: bankName ?? this.bankName,
      ifscCode: ifscCode ?? this.ifscCode,
      upiId: upiId ?? this.upiId,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        accountHolderName,
        accountNumber,
        bankName,
        ifscCode,
        upiId,
        isLoading,
      ];
}



