import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  ListScreenState createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  List<String> ideas = [];

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ideas = prefs.getStringList('ideas') ?? [];
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
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(idea),
                ),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/add');
          },
          child: const Icon(Icons.add),
        ));
  }
}
