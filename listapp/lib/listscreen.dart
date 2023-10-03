import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'textinputscreen.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  List<Map<String, dynamic>> ideas = [];

  @override
  void initState() {
    super.initState();
    loadIdeas();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    loadIdeas();
  }

  void loadIdeas() async {
    CollectionReference ideas = FirebaseFirestore.instance.collection('ideas');
    QuerySnapshot querySnapshot = await ideas.get();

    setState(() {
      this.ideas = querySnapshot.docs
          .map((doc) => {'text': doc['text'], 'id': doc.id})
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('List Screen'),
        ),
        body: ListView(
          children: [
            for (var idea in ideas)
              InkWell(
                onTap: () async {
                  String? action = await showDialog<String>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Idea'),
                      content: Text(
                          'Are you sure you want to edit or delete "${idea['text']}"?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, "delete");
                          },
                          child: const Text('Delete'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, "update");
                          },
                          child: const Text('Update'),
                        ),
                      ],
                    ),
                  );

                  if (action == 'delete') {
                    await FirebaseFirestore.instance
                        .collection('ideas')
                        .doc(idea['id'])
                        .delete();
                    setState(() {
                      ideas.remove(idea);
                    });
                  } else if (action == 'update') {
                    String? updatedIdea = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                TextInputScreen(existingIdea: idea)));

                    if (updatedIdea != null && updatedIdea != idea['text']) {
                      await FirebaseFirestore.instance
                          .collection('ideas')
                          .doc(idea['id'])
                          .update({'text': updatedIdea});
                      setState(() {
                        idea['text'] = updatedIdea;
                      });
                    }
                  }
                },
                child: Card(
                  child: ListTile(
                    title: Text(idea['text']),
                  ),
                ),
              )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.pushNamed(context, '/add');
            if (result == true) {
              loadIdeas();
            }
          },
          child: const Icon(Icons.add),
        ));
  }
}
