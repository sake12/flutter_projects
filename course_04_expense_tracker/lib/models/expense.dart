import 'package:course_04_expense_tracker/main.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum CategoryEnum { food, travel, leisure, work }

const categoryIcons = {
  CategoryEnum.food: Icons.lunch_dining,
  CategoryEnum.travel: Icons.flight,
  CategoryEnum.leisure: Icons.movie,
  CategoryEnum.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final CategoryEnum category;

  String get formattedDate => formatter.format(date);
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((x) => x.category == category).toList();

  final CategoryEnum category;
  final List<Expense> expenses;

  double get totalExpense {
    return expenses.fold(
      0,
      (previousValue, element) => previousValue + element.amount,
    );
  }
}
