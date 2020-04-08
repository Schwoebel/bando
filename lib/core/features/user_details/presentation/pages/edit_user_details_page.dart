import 'package:bando/core/features/user_details/domain/entities/user_details.dart';
import 'package:bando/core/features/user_details/presentation/pages/user_details_portal_page.dart';
import 'package:bando/core/features/user_details/presentation/widgets/add_author_dialog.dart';
import 'package:flutter/material.dart';

class EditUserDetailsPage extends StatefulWidget {
  final OnSaveUserDetailsCallback onSaveUserDetailsCallback;
  final UserDetails userDetails;

  const EditUserDetailsPage(
      {Key key, this.onSaveUserDetailsCallback, this.userDetails})
      : super(key: key);

  @override
  _EditUserDetailsPageState createState() => _EditUserDetailsPageState();
}

class _EditUserDetailsPageState extends State<EditUserDetailsPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  TextEditingController _emailTextController;
  TextEditingController _firstNameController;
  TextEditingController _lastNameController;
  UserDetails updatedUserDetails;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    updatedUserDetails = widget.userDetails;
    _emailTextController =
        TextEditingController(text: updatedUserDetails.email);
    _firstNameController =
        TextEditingController(text: updatedUserDetails.firstName);
    _lastNameController =
        TextEditingController(text: updatedUserDetails.lastName);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    _emailTextController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'First Name'),
                      controller: _firstNameController,
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Last Name'),
                      controller: _lastNameController,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 8.0,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email address'),
                controller: _emailTextController,
              ),
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Authors'),
                  IconButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (BuildContext context) => AddAuthDialog(
                          callback: (String value) {
                            List<dynamic> newAuthors = updatedUserDetails
                                .authors
                                .map((f) => f.toString())
                                .toList();
                            newAuthors.add(value);
                            updatedUserDetails = updatedUserDetails.copyWith(
                                authors: newAuthors);
                            setState(() {});
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.person_add),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: Icon(Icons.person_pin),
                      title: FlatButton(
                        onPressed: () {},
                        child: Text(
                          updatedUserDetails.authors[index],
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          List<dynamic> newAuthors = updatedUserDetails.authors
                              .map(
                                (f) => f.toString(),
                              )
                              .toList();
                          _confirmRemove(context, newAuthors, index);
                        },
                      ),
                    );
                  },
                  itemCount: updatedUserDetails.authors.length,
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          _triggerCallback();
        },
      ),
    );
  }

  Future<void> _confirmRemove(
      BuildContext context, List<dynamic> newAuthors, index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Are you sure you want to remove ${newAuthors[index]}"),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                newAuthors.remove(updatedUserDetails.authors[index]);
                updatedUserDetails =
                    updatedUserDetails.copyWith(authors: newAuthors);
                setState(() {});
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _triggerCallback() {
    widget.onSaveUserDetailsCallback(
      _firstNameController.text,
      _lastNameController.text,
      _emailTextController.text,
      updatedUserDetails.authors,
      updatedUserDetails.roles,
    );
    Navigator.pop(context);
  }
}
