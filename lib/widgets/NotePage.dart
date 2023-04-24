import 'package:flutter/material.dart';
import 'NoteForm.dart';
import 'NoteList.dart';

class Note {
  final String exercise;
  final int weight;
  final int reps;
  final DateTime date;

  Note({
    required this.exercise,
    required this.weight,
    required this.reps,
    required this.date,
  });
}

class NotePage extends StatefulWidget {
  const NotePage({Key? key}) : super(key: key);

  @override
  _NotePageState createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final List<Note> _notes = [];

  void _addNote(Note note) {
    setState(() {
      _notes.add(note);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FitQuest'),
        backgroundColor: Colors.red.shade700,
      ),
      body: Column(
        children: [
          NoteForm(onSubmit: _addNote),
          NoteList(notes: _notes),
        ],
      ),
    );
  }
}
