import 'package:flutter/material.dart';
import 'package:my_expenses/models/expense.dart';

class ExpenseTile extends StatelessWidget {
  final Expense expense;

  const ExpenseTile({
    super.key,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        expense.category.emoji,
        style: const TextStyle(fontSize: 24),
      ),
      title: Text(
        expense.title,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(expense.category.label),
      trailing: Text(
        '${expense.amount} դր.',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
      ),
    );
  }
}