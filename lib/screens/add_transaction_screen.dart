import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/transaction.dart';
import '../services/transaction_db.dart';

class AddTransactionScreen extends StatefulWidget {
  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() async {
    if (_titleController.text.isEmpty || _amountController.text.isEmpty) return;
    final title = _titleController.text;
    final amount = double.tryParse(_amountController.text);
    if (amount == null || amount <= 0) return;

    final tx = Transaction(
      id: const Uuid().v4(),
      title: title,
      amount: amount,
      date: _selectedDate,
    );

    await TransactionDB.addTransaction(tx);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('add expense')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Amount'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Tarih: ${_selectedDate.day}.${_selectedDate.month}.${_selectedDate.year}'),
              TextButton(onPressed: _presentDatePicker, child: const Text('Choose date'))
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitData,
            child: const Text('Add'),
          )
        ]),
      ),
    );
  }
}
