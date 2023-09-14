import 'package:flutter/material.dart';

class IdeaCard extends StatelessWidget {
  final String title;

  IdeaCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(title),
      ),
    );
  }
}
