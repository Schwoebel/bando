import 'package:bando/core/widgets/inputs/email_input_field/bloc/email_input_field_bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class EmailInputField extends StatefulWidget {
  final String initialValue;
final Function(String) onSavedCallback;
  EmailInputField({
    Key key,
    this.onSavedCallback,
    this.initialValue,
  }) : super(key: key);

  @override
  _EmailInputFieldState createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      onSaved: widget.onSavedCallback(_controller.text),
      autofocus: true,
      validator: _isValidEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "E-mail address",
        fillColor: Colors.white,
        filled: true,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        //
      ),
    );
  }

  String _isValidEmail(String email) {
    if (EmailValidator.validate(email) || email.isEmpty) {
      return null;
    } else {
      return 'Please enter a valid email address';
    }
  }
}
