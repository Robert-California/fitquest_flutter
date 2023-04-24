import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'NotePage.dart';

typedef OnSubmit = void Function(Note note);

class NoteForm extends StatefulWidget {
  final OnSubmit onSubmit;

  const NoteForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _exercise;
  int _weight = 0;
  int _reps = 0;
  DateTime? _date;

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onSubmit(Note(
        exercise: _exercise ?? '',
        weight: _weight,
        reps: _reps,
        date: _date ?? DateTime.now(),
      ));
      _formKey.currentState!.reset();
      setState(() {
        _date = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: _exercise,
            onChanged: (String? newValue) {
              setState(() {
                _exercise = newValue;
              });
            },
            items: [
              DropdownMenuItem(
                  child: Text('Vælg øvelse'),
                  value: '',
                  enabled: false), // Add this line
              DropdownMenuItem(child: Text('Bænkpres'), value: 'Bænkpres'),
              DropdownMenuItem(child: Text('Dødløft'), value: 'Dødløft'),
              DropdownMenuItem(child: Text('Squat'), value: 'Squat'),
            ],
            hint: const Text('Vælg øvelse'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select an exercise';
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              hintText: 'Vægt i KG',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter weight';
              }
              return null;
            },
            onSaved: (value) => _weight = int.parse(value!),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              hintText: 'Reps',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter reps';
              }
              return null;
            },
            onSaved: (value) => _reps = int.parse(value!),
          ),
          InkWell(
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
              );
              if (picked != null) {
                setState(() {
                  _date = picked;
                });
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                _date == null
                    ? 'Vælg dato'
                    : DateFormat('yyyy-MM-dd').format(_date!),
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _handleSubmit,
            child: const Text('Tilføj'),
          ),
        ],
      ),
    );
  }
}
