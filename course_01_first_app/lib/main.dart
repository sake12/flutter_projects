import 'package:flutter/material.dart';

import 'gradient_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter First App',
      theme: ThemeData(useMaterial3: true),
      home: const Scaffold(
        body: GradientContainer(
            Color.fromARGB(255, 39, 41, 192), Color.fromARGB(255, 8, 10, 114)),
      ),
    );
  }
}
