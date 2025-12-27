class BankDetailsData {
  final String? accountHolderName;
  final String? accountNumber;
  final String? bankName;
  final String? ifscCode;
  final String? upiId;

  const BankDetailsData({
    this.accountHolderName,
    this.accountNumber,
    this.bankName,
    this.ifscCode,
    this.upiId,
  });

  bool get hasBankDetails =>
      accountHolderName != null &&
      accountHolderName!.isNotEmpty &&
      accountNumber != null &&
      accountNumber!.isNotEmpty &&
      bankName != null &&
      bankName!.isNotEmpty &&
      ifscCode != null &&
      ifscCode!.isNotEmpty;

  bool get hasUpiId => upiId != null && upiId!.isNotEmpty;

  bool get isValid => hasBankDetails || hasUpiId;
}


