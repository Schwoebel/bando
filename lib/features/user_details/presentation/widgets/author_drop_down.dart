import 'package:bando/features/user_details/presentation/bloc/author/author_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthorDropDown extends StatefulWidget {
  final Function(String) onSelected;
  final value;

  AuthorDropDown({Key key, this.onSelected, this.value = ''}) : super(key: key);

  @override
  _AuthorDropDownState createState() => _AuthorDropDownState();
}

class _AuthorDropDownState extends State<AuthorDropDown> {
  String value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthorBloc, AuthorState>(
        builder: (BuildContext context, AuthorState state) {
      if (state is HasAuthors) {
        return Row(
          children: <Widget>[
            Expanded(
              child: DropdownButtonFormField<String>(
                hint: Text('Author:'),
                value: value.isNotEmpty ? value : null,
                onChanged: (String newValue) {
                  value = newValue;
                  BlocProvider.of<AuthorBloc>(context).add(
                    AuthorSelected(
                      state.authors,
                    ),
                  );
                  widget.onSelected(newValue);
                },
                items: state.authors
                    .map(
                      (dynamic author) => DropdownMenuItem<String>(
                          child: Text(author), value: author),
                    )
                    .toList(),
              ),
            )
          ],
        );
      } else {
        return SizedBox();
      }
    });
  }
}
