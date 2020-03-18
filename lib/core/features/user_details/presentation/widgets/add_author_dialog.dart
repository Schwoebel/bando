import 'package:baindo/core/features/user_details/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAuthDialog extends StatefulWidget {
  @override
  _AddAuthDialogState createState() => _AddAuthDialogState();
}

class _AddAuthDialogState extends State<AddAuthDialog>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  TextEditingController _textController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _textController = TextEditingController();
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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Form(
        key: _formKey,
        child: Container(
          height: 250.0,
          width: 300.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Add new Author',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: TextFormField(
                        controller: _textController,
                        validator: (String value){
                          if (value.isEmpty) {
                            return 'Please enter a new author name';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: "Name"),
                      ),
                    ),
                  )
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    MaterialButton(
                      color: Color(Colors.blue.value),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                         BlocProvider.of<UserDetailsBloc>(context).add(UpdateAuthorList(_textController.text));
                        }
                      },

                      child: Text(
                        'Okay',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    MaterialButton(
                      color: Color(Colors.redAccent.value),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Cancel',
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}