import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/add_entry/add_entry_bloc.dart';
import 'package:baindo/features/manage_entries/presentation/widgets/entry_editor.dart';
import 'package:baindo/core/features/mood/presentation/bloc/mood/mood_bloc.dart';
import 'package:baindo/core/features/mood/presentation/widgets/mood_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';

class AddEntryPage extends StatefulWidget {
  final String personOfInterest;

  AddEntryPage({Key key, @required this.personOfInterest}) : super(key: key);

  @override
  _AddEntryPageState createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  Entry entry;

  @override
  void initState() {
    int now = DateTime
      .now()
      .millisecondsSinceEpoch;
    entry = Entry(
      createDate: now,
      author: '',
      metaData: {'mood': 'Happy'},
      text: '',
      title: '',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<AddEntryBloc>(
            create: (_) => sl<AddEntryBloc>(),
          ),
          BlocProvider<MoodBloc>(
            create: (_) =>
            sl<MoodBloc>()
              ..add(
                GetMoodsEvent(),
              ),
          )
        ],
        child: BlocListener<AddEntryBloc, AddEntryState>(
          listener: (BuildContext context, AddEntryState state) {
            if (state is NewEntrySubmittedSuccessfully) {
              Navigator.pop(context);
            } else if (state is SubmittingNewEntry) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Entry Saved'),
                ),
              );
              Navigator.pop(context);
            } else if (state is ErrorSubmittingEntry) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error saving Entry, please try again later'),
                ),
              );
            } else if (state is HasEntryInProgress) {
              entry = state.entry;
            }
          },
          child: BlocBuilder<AddEntryBloc, AddEntryState>(
            builder: (BuildContext context, AddEntryState addEntryState) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      MoodDropdown(
                        entry: entry,
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4.0, color: Colors.greenAccent),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            )),
                          constraints: BoxConstraints.expand(),
                          child: EntryEditor(entry: entry),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        constraints: BoxConstraints(
                          minWidth: 50,
                          maxWidth: 100,
                        ),
                        child: ButtonTheme(
                          minWidth: 300,
                          height: 50,
                          child: RaisedButton(
                            color: Color(0xFFc2e59c),
                            onPressed: () =>
                              BlocProvider.of<AddEntryBloc>(context).add(
                                SaveEntry(entry, widget.personOfInterest),
                              ),
                            child: Text('Submit'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
