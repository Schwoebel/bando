import 'package:baindo/features/manage_entries/domain/entities/mood.dart';
import 'package:baindo/features/manage_entries/injection_container.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/mood/mood_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoodSelector extends StatefulWidget {
  final String mood = 'Happy';
  final Function callback;

  MoodSelector({Key key, this.callback}) : super(key: key);

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
            value: state.moods[0].id,
            items: state.moods.map<DropdownMenuItem<int>>((Mood mood) {
              return DropdownMenuItem<int>(
                  value: mood.id, child: Text(mood.mood));
            }).toList(),
            onChanged: (value) {
              widget.callback(widget.mood);
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
