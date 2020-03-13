import 'package:baindo/core/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:baindo/core/theme/bando_theme.dart';
import 'package:baindo/features/manage_person_of_interest/presentation/bloc/person_of_interest/person_of_interest_bloc.dart';
import 'package:baindo/features/view_entries/domain/entities/view_entry_arguments.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonOfInterestPage extends StatefulWidget {
  @override
  _PersonOfInterestPageState createState() => _PersonOfInterestPageState();
}

class _PersonOfInterestPageState extends State<PersonOfInterestPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    BlocProvider.of<PersonOfInterestBloc>(context)
        .add(ReadAllowedPersonsOfInterestEvent());
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Journals'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<PersonOfInterestBloc>(context).add(
                ReadAllowedPersonsOfInterestEvent(),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.people),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(
                SignOutEvent(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<PersonOfInterestBloc, PersonOfInterestState>(
        builder: (BuildContext context, PersonOfInterestState state) {
          if (state is GetAllPersonsOfInterestComplete) {
            return ListView.separated(
              separatorBuilder: (context, int) =>
                  Divider(color: BandoColors.blue[200]),
              itemCount: state.personsOfInterest.length,
              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {
                    Navigator.pushNamed(context, '/viewEntries',
                        arguments: ViewEntriesArgs(
                            id: state.personsOfInterest[index].id));
                  },
                  title: Text(state.personsOfInterest[index].initials),
                  trailing: Icon(Icons.keyboard_arrow_right),
                );
              },
            );
          } else if (state is ErrorWithPersonOfInterestProcess) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
