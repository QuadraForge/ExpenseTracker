import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionTile extends StatelessWidget {
  final Transaction transaction;
  final VoidCallback onDelete;

  const TransactionTile({
    Key? key,
    required this.transaction,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      elevation: 3,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: transaction.amount >= 0 ? Colors.green : Colors.red,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '${transaction.amount.toStringAsFixed(2)}₺',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${transaction.date.day}.${transaction.date.month}.${transaction.date.year}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
