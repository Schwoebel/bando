import 'package:baindo/core/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:baindo/core/features/user_details/domain/entities/role.dart';
import 'package:baindo/core/features/user_details/domain/entities/user_details.dart';
import 'package:baindo/core/features/user_details/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:baindo/core/features/user_details/presentation/pages/user_details_portal_page.dart';
import 'package:baindo/core/theme/bando_theme.dart';
import 'package:baindo/features/manage_person_of_interest/presentation/bloc/person_of_interest/person_of_interest_bloc.dart';
import 'package:baindo/features/entries/domain/entities/view_entry_arguments.dart';
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
    BlocProvider.of<PersonOfInterestBloc>(context).add(
      ReadAllowedPersonsOfInterestEvent(),
    );
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.person_add),
        onPressed: () {
          Navigator.pushNamed(context, '/addPoi');
        },
      ),
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
          _userDetailsButton(),
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
            return ListView.builder(
              itemCount: state.personsOfInterest.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/viewEntries',
                        arguments: ViewEntriesArgs(
                          id: state.personsOfInterest[index].id,
                        ),
                      );
                    },
                    title: Text(state.personsOfInterest[index].initials),
                    leading: Icon(Icons.book),
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                );
              },
            );
          } else if (state is ErrorWithPersonOfInterestProcess) {
            return Center(child: Text(state.message));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _userDetailsButton() {
    return BlocListener<UserDetailsBloc, UserDetailsState>(
      child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
          builder: (context, UserDetailsState state) {
        if (state is UserDetailsRetrieved) {
          return IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/userDetails',
                arguments: UserDetailsPageArgs(
                  (
                    String firstName,
                    String lastName,
                    String emailAddress,
                    List<dynamic> authors,
                    List<Role> roles,
                  ) {
                    UserDetails updatedUserDetails = state.userDetails.copyWith(
                      email: emailAddress,
                      firstName: firstName,
                      lastName: lastName,
                      roles: roles,
                      authors: authors,
                    );
                    BlocProvider.of<UserDetailsBloc>(context).add(
                      UpdateUserDetails(
                        updatedUserDetails,
                      ),
                    );
                  },
                  state.userDetails,
                ),
              );
            },
          );
        } else {
          return IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {},
          );
        }
      }),
      listener: (BuildContext context, UserDetailsState state) {
        if (state is UserDetailsRetrieved) {
          if (state.fromUpdate == true) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Settings Udated'),
            ));
          }
        }
      },
    );
  }
}
