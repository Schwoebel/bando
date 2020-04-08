import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class PasswordField extends StatefulWidget {
  final Function(String) onSavedCallback;

  PasswordField({Key key, @required this.onSavedCallback}) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
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
    );
  }
}
