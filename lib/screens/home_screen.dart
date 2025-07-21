import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/transaction_db.dart';
import '../screens/add_transaction_screen.dart';
import '../widgets/transaction_tile.dart';
import '../widgets/balance_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Transaction> _transactions = [];

  Future<void> _loadTransactions() async {
    final txs = await TransactionDB.getTransactions();
    setState(() => _transactions = txs.reversed.toList());
  }

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    double total = _transactions.fold(0.0, (sum, t) => sum + t.amount);

    return Scaffold(
      appBar: AppBar(title: const Text('Personel finance')),
      body: Column(
        children: [
          BalanceCard(balance: total),
          Expanded(
            child: _transactions.isEmpty
                ? const Center(child: Text('No transactions yet.'))
                : ListView.builder(
              itemCount: _transactions.length,
              itemBuilder: (ctx, i) => TransactionTile(
                transaction: _transactions[i],
                onDelete: () async {
                  await TransactionDB.deleteTransaction(_transactions[i].id);
                  _loadTransactions();
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => AddTransactionScreen()),
          );
          _loadTransactions();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
