import 'package:baindo/core/features/mood/presentation/bloc/mood/mood_bloc.dart';
import 'package:baindo/core/features/user_details/domain/entities/user_details.dart';
import 'package:baindo/core/features/user_details/presentation/bloc/user_details/user_details_bloc.dart';
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
    UserDetails userDetails = (BlocProvider.of<UserDetailsBloc>(context).state as UserDetailsRetrieved).userDetails;
    return Row(
      children: <Widget>[
        Expanded(
          child: DropdownButton<dynamic>(
            value: value.isNotEmpty ? value : null,
            onChanged: (dynamic newValue) {
              value = newValue;
              widget.onSelected(newValue);
            },
            items: userDetails.authors
                .map(
                  (dynamic author) => DropdownMenuItem<String>(
                      child: Text(author), value: author),
                )
                .toList(),
          ),
        )
      ],
    );
  }
}
