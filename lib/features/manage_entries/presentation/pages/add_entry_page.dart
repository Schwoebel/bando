import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:baindo/features/manage_entries/domain/entities/mood.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/add_entry/add_entry_bloc.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/mood/mood_bloc.dart';
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
  TextEditingController _controller;
  Entry entry;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(_listener);
    int now = DateTime.now().millisecondsSinceEpoch;
    entry = Entry(
      now,
      '',
      'Happy',
      widget.personOfInterest,
    );
    super.initState();
  }

  _listener() {
    entry = Entry(entry.createDate, _controller.value.text, entry.mood,
        widget.personOfInterest);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            create: (_) => sl<MoodBloc>()
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
            } else if (state is ErrorSubmittingEntry) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error saving Entry, please try again later'),
                ),
              );
            }
          },
          child: BlocBuilder<AddEntryBloc, AddEntryState>(
            builder: (BuildContext context, AddEntryState addEntryState) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      BlocBuilder<MoodBloc, MoodState>(
                        builder: (BuildContext context, MoodState moodState) {
                          if (moodState is InitialMoodState) {
                            return SizedBox();
                          } else if (moodState is HasMoodsState) {
                            return Row(
                              children: <Widget>[
                                Expanded(
                                  child: DropdownButton<String>(
                                    value: entry.mood,
                                    onChanged: (String newValue) {
                                      entry.mood = newValue;
                                      BlocProvider.of<AddEntryBloc>(context)
                                          .add(CreateEntry(entry));
                                    },
                                    items: moodState.moods
                                        .map(
                                          (Mood mood) =>
                                              DropdownMenuItem<String>(
                                                  child: Text(mood.mood),
                                                  value: mood.mood),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'How did the day go?',
                        ),
                        minLines: 6,
                        controller: _controller,
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
                              SaveEntry(entry),
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
