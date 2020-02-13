import 'package:baindo/features/manage_entries/injection_container.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/create_entry/create_entry_bloc.dart';
import 'package:baindo/features/manage_entries/presentation/widgets/entry_form.dart';
import 'package:baindo/features/manage_entries/presentation/widgets/mood_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEntryPage extends StatefulWidget {
  final String personOfInterest;

  const AddEntryPage({Key key, this.personOfInterest}) : super(key: key);

  @override
  _AddEntryPageState createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  String defaultMood = 'Happy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: BlocProvider(
        create: (_) => sl<CreateEntryBloc>(),
        child: BlocBuilder<CreateEntryBloc, CreateEntryState>(
          builder: (BuildContext context, CreateEntryState state) {
            if (state is EntryInProgress) {
              return EntryForm();
            } else if (state is InitialCreateEntryState) {
              BlocProvider.of<CreateEntryBloc>(context).add(
                InitializeEntryEvent(),
              );
              return CircularProgressIndicator();
            } else {
              return SizedBox();
            }
          },
        ),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
