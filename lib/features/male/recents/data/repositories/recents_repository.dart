import '../../domain/entities/call_record.dart';
import '../../domain/entities/transaction_record.dart';

abstract class RecentsRepository {
  Future<List<TransactionRecord>> getTransactionHistory();
  Future<List<CallRecord>> getCallHistory();
}

class RecentsRepositoryImpl implements RecentsRepository {
  @override
  Future<List<TransactionRecord>> getTransactionHistory() async {
    // Dummy static data to match the design
    return [
      TransactionRecord(
        packageName: 'Starter Package',
        rechargeType: 'Recharge',
        coins: 1000,
        dateTime: DateTime(2025, 12, 12, 11, 0),
      ),
      TransactionRecord(
        packageName: 'Mega Package',
        rechargeType: 'Recharge',
        coins: 1000,
        dateTime: DateTime(2025, 12, 10, 0, 0),
      ),
      TransactionRecord(
        packageName: 'VIP Package',
        rechargeType: 'Recharge',
        coins: 5000,
        dateTime: DateTime(2025, 12, 5, 18, 30),
      ),
    ];
  }

  @override
  Future<List<CallRecord>> getCallHistory() async {
    return [
      CallRecord(
        userName: 'Meghana',
        duration: const Duration(minutes: 5),
        coins: 100,
        dateTime: DateTime(2025, 12, 12, 11, 0),
      ),
      CallRecord(
        userName: 'Meghana',
        duration: const Duration(minutes: 5),
        coins: 100,
        dateTime: DateTime(2025, 12, 10, 0, 0),
      ),
      CallRecord(
        userName: 'Meghana',
        duration: const Duration(minutes: 3, seconds: 30),
        coins: 60,
        dateTime: DateTime(2025, 12, 5, 19, 0),
      ),
    ];
  }
}


