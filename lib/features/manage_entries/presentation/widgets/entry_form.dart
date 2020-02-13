import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:baindo/features/manage_entries/domain/entities/mood.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/create_entry/create_entry_bloc.dart';
import 'package:baindo/features/manage_entries/presentation/widgets/mood_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryForm extends StatefulWidget {
  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _entryController = TextEditingController();

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MoodSelector(
            callback: (Mood value) {

            },
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _entryController,
            onChanged: (value) {
            },
          ),
          RaisedButton(
            child: Text('Submit'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
  _emitUpdate(BuildContext context, Entry updatedEntry) {
    BlocProvider.of<CreateEntryBloc>(context)
      .add(UpdateEntry(entry: updatedEntry));
  }
}
