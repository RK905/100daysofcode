import 'package:flutter/material.dart';
import 'listscreen.dart';
import 'textinputscreen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListScreen(),
      routes: {
        '/list': (context) => ListScreen(),
        '/add': (context) => TextInputScreen(),
      },
    );
  }
}
