import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TextInputScreen extends StatefulWidget {
  @override
  _TextInputScreenState createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  String text = '';

  TextEditingController controller = TextEditingController();

  _saveIdea() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> ideas = prefs.getStringList('ideas') ?? [];
    ideas.add(text);
    await prefs.setStringList('ideas', ideas);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Input Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: text.isEmpty ? null : _saveIdea,
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
