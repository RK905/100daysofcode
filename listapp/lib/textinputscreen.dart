import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TextInputScreen extends StatefulWidget {
  final Map<String, dynamic>? existingIdea;
  TextInputScreen({this.existingIdea});

  @override
  _TextInputScreenState createState() => _TextInputScreenState();
}

class _TextInputScreenState extends State<TextInputScreen> {
  String text = '';

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existingIdea != null) {
      text = widget.existingIdea!['text'];
      controller.text = text;
    }
  }

  _saveIdea() async {
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    CollectionReference ideas = FirebaseFirestore.instance.collection('ideas');

    if (widget.existingIdea == null) {
      await ideas.add({
        'text': text,
        'created': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context, true); // pop with a value
      return;
    } else {
      await ideas.doc(widget.existingIdea!['id']).update({
        'text': text,
        'updated': FieldValue.serverTimestamp(),
      });
      Navigator.pop(context, text); // pop with a value
    }
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
