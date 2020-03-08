import 'package:baindo/features/manage_entries/domain/entities/entry.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/add_entry/add_entry_bloc.dart';
import 'package:baindo/features/mood/domain/entities/mood.dart';
import 'package:baindo/features/mood/presentation/bloc/mood/mood_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoodDropdown extends StatefulWidget {
  final Entry entry;
  MoodDropdown({Key key, @required this.entry}) : super(key: key);

  @override
  _MoodDropdownState createState() => _MoodDropdownState();
}

class _MoodDropdownState extends State<MoodDropdown> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodBloc, MoodState>(
      builder: (BuildContext context, MoodState moodState) {
        if (moodState is InitialMoodState) {
          return SizedBox();
        } else if (moodState is HasMoodsState) {
          return Row(
            children: <Widget>[
              Expanded(
                child: DropdownButton<String>(
                  value: widget.entry.mood,
                  onChanged: (String newValue) {
                    widget.entry.mood = newValue;
                    BlocProvider.of<AddEntryBloc>(context)
                      .add(CreateEntry(widget.entry));
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
    );
  }
}