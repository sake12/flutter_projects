import 'package:course_04_expense_tracker/widgets/chart/chart.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';
import 'expenses_list/expenses_list.dart';
import 'new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 't1',
      amount: 12.3,
      date: DateTime.now(),
      category: CategoryEnum.food,
    ),
    Expense(
      title: 't2',
      amount: 23.4,
      date: DateTime.now(),
      category: CategoryEnum.leisure,
    )
  ];

  _openAddExpenseOverlay() async {
    var newExpense = await showModalBottomSheet<Expense>(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => const NewExpense(),
    );

    if (newExpense == null) {
      return;
    }

    setState(() {
      _registeredExpenses.add(newExpense);
    });
  }

  _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).clearSnackBars();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Usunięto...'),
        action: SnackBarAction(
            label: 'Cofnij',
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(expenseIndex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('Dodaj coś...'),
    );

    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expensesList: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense tracker"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openAddExpenseOverlay,
          )
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredExpenses),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
