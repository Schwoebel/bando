import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class PasswordField extends StatefulWidget {
  final Function callback;
  PasswordField({Key key, @required this.callback}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value.isEmpty) return "you're empty bro";
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        fillColor: Colors.white,
        filled: true,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
        //
      ),
      onChanged: widget.callback,
    );
  }
}