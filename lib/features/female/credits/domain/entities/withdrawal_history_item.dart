class WithdrawalHistoryItem {
  final DateTime dateTime;
  final String transactionId;
  final int amount;

  const WithdrawalHistoryItem({
    required this.dateTime,
    required this.transactionId,
    required this.amount,
  });
}


