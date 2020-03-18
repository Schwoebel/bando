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
    //TODO When this form is submitted with a change I need to update the firebase user's email address and the author name of any entries this user has submitted
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'First Name'),
                    controller: _firstNameController,
                  ),
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(labelText: 'Last Name'),
                    controller: _lastNameController,
                  ),
                )
              ],
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Email address'),
              controller: _emailTextController,
            ),
            Padding(padding: EdgeInsets.all(8),),
            Text('Authors'),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.person_pin),
                      title: Text(
                        widget.userDetails.authors[index],
                      ),
                    );
                  },
                  itemCount: widget.userDetails.authors.length),
            )
          ],
        ),
      ),
    );
  }
}
