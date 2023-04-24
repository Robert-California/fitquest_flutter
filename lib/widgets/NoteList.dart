import 'package:flutter/material.dart';
import 'NotePage.dart';

class NoteList extends StatelessWidget {
  final List<Note> notes;

  const NoteList({Key? key, required this.notes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return ListTile(
          tileColor: Colors.white,
          title: Text(
            '${note.exercise}, ${note.weight} kg, ${note.reps} reps, ${note.date.toLocal().toString().split(' ')[0]}',
          ),
        );
      },
    );
  }
}
