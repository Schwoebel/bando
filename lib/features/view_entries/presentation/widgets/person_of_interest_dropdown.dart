import '../../../../features/manage_person_of_interest/domain/entities/person_of_interest_entity.dart';
import 'package:baindo/features/view_entries/presentation/bloc/dropdown_button/dropdown_button_bloc.dart';
import 'package:flutter/material.dart';

import 'package:baindo/features/view_entries/presentation/bloc/view_entries/view_entries_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';

class PersonOfInterestDropdown extends StatefulWidget {
  final List<PersonOfInterest> personsOfInterest;
  final Function(String value) callback;

  PersonOfInterestDropdown({Key key, this.personsOfInterest, this.callback})
      : super(key: key);

  @override
  _PersonOfInterestDropdownState createState() =>
      _PersonOfInterestDropdownState();
}

class _PersonOfInterestDropdownState extends State<PersonOfInterestDropdown> {
  @override
  void initState() {
    BlocProvider.of<ViewEntriesBloc>(context).add(
      LoadEntriesEvent(
        widget.personsOfInterest[0].id,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DropdownButtonBloc>(
      create: (BuildContext context) => sl<DropdownButtonBloc>(),
      child: BlocListener<DropdownButtonBloc, DropdownButtonState>(
        listener: (BuildContext context, DropdownButtonState state) {
          if (state is ValueChangedState) {
            widget.callback(state.newValue);
          } else if (state is InitialDropdownButtonState) {
            BlocProvider.of<ViewEntriesBloc>(context).add(
              LoadEntriesEvent(
                widget.personsOfInterest[0].id,
              ),
            );
          }
        },
        child: BlocBuilder<DropdownButtonBloc, DropdownButtonState>(
          builder: (BuildContext context, DropdownButtonState state) {
            return DropdownButton<String>(
              onChanged: (String newValue) {
                BlocProvider.of<DropdownButtonBloc>(context)
                    .add(ChangeValueEvent(newValue: newValue));
              },
              value: state is ValueChangedState
                  ? state.newValue
                  : widget.personsOfInterest[0].id,
              items: widget.personsOfInterest
                  .map<DropdownMenuItem<String>>(
                    (PersonOfInterest person) => DropdownMenuItem<String>(
                      value: person.id,
                      child: Text(person.initials),
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
