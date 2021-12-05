import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/note.dart';

void main(List<String> args) {
  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> notes = [];
  Client client = http.Client();

  @override
  void initState() {
    _getNotes();
    super.initState();
  }

  _getNotes() async {
    notes = [];
    var url = Uri.https('angularcurd.herokuapp.com', '/users');

    List response = json.decode((await client.get(url)).body);
    response.forEach((element) {
      notes.add(Note.fromMap(element));
    });
    setState(() {});
  }

  void _deleteNote(int id) {
    var delete_url = Uri.https('angularcurd.herokuapp.com', '/users/$id/');
    client.delete(delete_url);
    _getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Stack Stores'),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            _getNotes();
          },
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(notes[index].email),
                trailing: IconButton(
                  onPressed: () {
                    _deleteNote(notes[index].id);
                  },
                  icon: Icon(Icons.delete),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
