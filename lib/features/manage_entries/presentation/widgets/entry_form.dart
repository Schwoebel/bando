import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/create_entry/create_entry_bloc.dart';
import 'package:baindo/features/manage_entries/presentation/widgets/mood_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EntryForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _entryController = TextEditingController();
  final Entry newEntry;

  EntryForm({@required this.newEntry});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          MoodSelector(
            callback: (int value) {
              _emitUpdate(
                context,
                Entry(
                  newEntry.entry,
                  value,
                  newEntry.personOfInterest,
                ),
              );
            },
          ),
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            controller: _entryController,
            onChanged: (value) {
              _emitUpdate(
                context,
                Entry(
                  value,
                  newEntry.mood,
                  newEntry.personOfInterest,
                ),
              );
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
