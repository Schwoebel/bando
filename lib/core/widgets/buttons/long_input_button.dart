import 'package:flutter/material.dart';

class LongInputButton extends StatelessWidget {
  final Function callback;
  final String buttonText;

  const LongInputButton({Key key, @required this.callback, @required this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(18.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(8), child: Text(buttonText)),
      color: Color(0xFF10b3e5),
      textColor: Colors.white,
      onPressed: callback,
    );
  }
}
