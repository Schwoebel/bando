import 'package:baindo/core/features/user_details/domain/entities/user_details.dart';
import 'package:flutter/material.dart';

class UserDetailsForm extends StatefulWidget {
  final UserDetails userDetails;

  const UserDetailsForm({Key key, this.userDetails}) : super(key: key);

  @override
  _UserDetailsFormState createState() => _UserDetailsFormState();
}

class _UserDetailsFormState extends State<UserDetailsForm>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  TextEditingController _emailTextController;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _emailTextController =
        TextEditingController(text: widget.userDetails.email);
    _firstNameController =
        TextEditingController(text: widget.userDetails.firstName);
    _lastNameController =
        TextEditingController(text: widget.userDetails.lastName);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(),
                    controller: _firstNameController,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(),
                    controller: _lastNameController,
                  ),
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(),
              controller: _emailTextController,
            ),
          ],
        ),
      ),
    );
  }
}
