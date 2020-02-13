import 'package:baindo/features/manage_entries/domain/entities/mood.dart';
import 'package:baindo/features/manage_entries/injection_container.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/mood/mood_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoodSelector extends StatefulWidget {
  final Function callback;
  final Mood mood;

  MoodSelector({Key key, this.callback, this.mood}) : super(key: key);

  @override
  _MoodSelectorState createState() => _MoodSelectorState();
}

class _MoodSelectorState extends State<MoodSelector> {
  MoodBloc bloc;

  @override
  void initState() {
    bloc = sl<MoodBloc>();
    bloc.add(GetMoodsEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodBloc, MoodState>(
      bloc: bloc,
      builder: (BuildContext context, MoodState state) {
        if (state is HasMoodsState) {
          return DropdownButton(
            value: widget.mood,
            items: state.moods.map<DropdownMenuItem<Mood>>((Mood mood) {
              return DropdownMenuItem<Mood>(
                  value: mood, child: Text(mood.mood));
            }).toList(),
            onChanged: (value) {
              widget.callback(value);
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
