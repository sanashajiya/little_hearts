class TransactionRecord {
  final String packageName;
  final String rechargeType;
  final int coins;
  final DateTime dateTime;

  const TransactionRecord({
    required this.packageName,
    required this.rechargeType,
    required this.coins,
    required this.dateTime,
  });
}


