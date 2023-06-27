import 'package:flutter/material.dart';

import 'package:course_04_expense_tracker/widgets/expenses.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat('yyyy-MM-dd');

void main() {
  runApp(
    const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('pl'),
        Locale('en'),
      ],
      home: Expenses(),
    ),
  );
}
