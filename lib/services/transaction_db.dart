import 'package:hive/hive.dart';
import '../models/transaction.dart';

class TransactionDB {
  static const String boxName = 'transactions_box';

  static Future<Box<Transaction>> openBox() async {
    return await Hive.openBox<Transaction>(boxName);
  }

  static Future<void> addTransaction(Transaction transaction) async {
    final box = await openBox();
    await box.put(transaction.id, transaction);
  }

  static Future<List<Transaction>> getTransactions() async {
    final box = await openBox();
    return box.values.toList();
  }

  static Future<void> deleteTransaction(String id) async {
    final box = await openBox();
    await box.delete(id);
  }
}
