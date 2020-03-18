import 'package:baindo/core/features/user_details/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:baindo/core/features/user_details/presentation/widgets/add_author_dialog.dart';
import 'package:baindo/core/features/user_details/presentation/widgets/user_details_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injection_container.dart';

class UserDetailsPage extends StatefulWidget {
  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserDetailsBloc>(
      create: (BuildContext context) =>
          sl<UserDetailsBloc>()..add(GetUserDetailsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Details'),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => AddAuthDialog());
              },
              icon: Icon(Icons.person_add),
            )
          ],
        ),
        body: BlocProvider<UserDetailsBloc>(
          create: (BuildContext context) =>
              sl<UserDetailsBloc>()..add(GetUserDetailsEvent()),
          child: BlocBuilder<UserDetailsBloc, UserDetailsState>(
            builder: (BuildContext context, UserDetailsState state) {
              if (state is Waiting || state is InitialUserDetailsState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserDetailsRetrieved) {
                return UserDetailsForm(
                  userDetails: state.userDetails,
                );
              } else if (state is ErrorRetrievingUserDetails) {
                return Center(
                  child: Text(
                    state.message,
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ),

      ),
    );
  }
}
