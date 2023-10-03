import 'package:flutter/material.dart';
import 'listscreen.dart';
import 'textinputscreen.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
