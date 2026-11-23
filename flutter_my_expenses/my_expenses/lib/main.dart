import 'package:flutter/material.dart';
import 'package:my_expenses/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My expenses',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
