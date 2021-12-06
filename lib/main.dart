import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:mobileapp/create.dart';
import 'package:mobileapp/note.dart';
import 'package:mobileapp/update.dart';

import 'package:http/http.dart' as http;
import 'package:mobileapp/urls.dart';

void main(List<String> args) {
  runApp(MaterialApp(home: HomePage()));
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
    List response = json.decode((await client.get(urlRetrieveCreate())).body);
    response.forEach((element) {
      notes.add(Note.fromMap(element));
    });
    setState(() {});
  }

  void _deleteNote(int id) {
    client.delete(urlDeleteUpdate(id));
    _getNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFdde0e3),
      appBar: AppBar(
        title: const Text('Stack Stores'),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: RefreshIndicator(
          onRefresh: () async {
            _getNotes();
          },
          child: ListView.builder(
            itemCount: notes.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: ListTile(
                title: Text(notes[index].email),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UpdatePage(
                        client: client,
                        id: notes[index].id,
                        email: notes[index].email,
                      ),
                    ),
                  );
                },
                trailing: IconButton(
                  onPressed: () {
                    _deleteNote(notes[index].id);
                  },
                  icon: Icon(Icons.delete),
                ),
              ));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CreatePage(
                      client: client,
                    )),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
