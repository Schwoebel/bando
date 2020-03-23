import 'package:baindo/core/features/mood/domain/entities/mood.dart';
import 'package:baindo/core/features/mood/presentation/bloc/mood/mood_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoodDropdown extends StatefulWidget {
  final Function(String) onSelected;
  final value;

  MoodDropdown({Key key, this.onSelected, this.value = ''}) : super(key: key);

  @override
  _MoodDropdownState createState() => _MoodDropdownState();
}

class _MoodDropdownState extends State<MoodDropdown> {
  String value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodBloc, MoodState>(
      builder: (BuildContext context, MoodState moodState) {
        if (moodState is HasMoodsState) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: DropdownButton<String>(
                  value: value.isNotEmpty ? value : null,
                  onChanged: (String newValue) {
                    value = newValue;
                    BlocProvider.of<MoodBloc>(context)
                        .add(MoodSelected(moodState.moods));
                    widget.onSelected(newValue);
                  },
                  items: moodState.moods
                      .map(
                        (Mood mood) => DropdownMenuItem<String>(
                            child: Text(mood.mood), value: mood.mood),
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
