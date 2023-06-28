import 'package:course_04_expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

import 'expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expensesList,
    required this.onRemoveExpense,
  });

  final List<Expense> expensesList;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expensesList.length,
      itemBuilder: (context, index) => Dismissible(
        key: ValueKey(expensesList[index]),
        onDismissed: (direction) {
          onRemoveExpense(expensesList[index]);
        },
        child: ExpenseItem(expensesList[index]),
      ),
    );
  }
}
