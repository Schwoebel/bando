import 'package:bando/features/user_details/domain/entities/role.dart';

import '../../domain/entities/user_details.dart';

import 'edit_user_details_page.dart';
import 'package:flutter/material.dart';

typedef OnSaveUserDetailsCallback = Function(
  String firstName,
  String lastName,
  String emailAddress,
  List<dynamic> authors,
  List<Role> roles,
);

class UserDetailsPortalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final UserDetailsPageArgs args = ModalRoute.of(context).settings.arguments;
    return EditUserDetailsPage(
        onSaveUserDetailsCallback: args.onSaveUserDetailsCallback,
        userDetails: args.userDetails);
  }
}

class UserDetailsPageArgs {
  final OnSaveUserDetailsCallback onSaveUserDetailsCallback;
  final UserDetails userDetails;

  UserDetailsPageArgs(this.onSaveUserDetailsCallback, this.userDetails);
}
