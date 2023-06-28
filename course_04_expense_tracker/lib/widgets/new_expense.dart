import 'package:course_04_expense_tracker/main.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  CategoryEnum _selectedCategory = CategoryEnum.leisure;

  void _onCategoryChange(CategoryEnum? category) {
    if (category == null) {
      return;
    }

    setState(() {
      _selectedCategory = category;
    });
  }

  void _showDatePicker() async {
    final now = DateTime.now();
    final first = DateTime(DateTime.now().year - 2);
    final last = DateTime(DateTime.now().year + 2);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: first,
      lastDate: last,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  _onSubmitData() {
    final enteredAmount =
        double.tryParse(_amountController.text.replaceAll(',', '.'));

    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Błąd'),
                content: const Text('Uzupełnij dane poprawnie...'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Ok'))
                ],
              ));
      return;
    }

    Navigator.pop(
        context,
        Expense(
            title: _titleController.text,
            amount: enteredAmount,
            date: _selectedDate!,
            category: _selectedCategory));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text("Tytuł"),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  suffixText: 'zł',
                  label: Text("Wartość"),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? '---'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                    onPressed: _showDatePicker,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            DropdownButton(
                value: _selectedCategory,
                items: CategoryEnum.values
                    .map((x) => DropdownMenuItem(
                          value: x,
                          child: Text(x.name.toUpperCase()),
                        ))
                    .toList(),
                onChanged: _onCategoryChange),
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Anuluj'),
            ),
            ElevatedButton(
              onPressed: _onSubmitData,
              child: const Text('Zapisz'),
            )
          ],
        )
      ]),
    );
  }
}
