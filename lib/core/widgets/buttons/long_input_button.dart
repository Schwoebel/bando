import 'package:flutter/material.dart';

class LongInputButton extends StatelessWidget {
  final Function callback;
  final String buttonText;
  final double padding;
  final Color color;
  final double fontSize;

  const LongInputButton({
    Key key,
    @required this.callback,
    @required this.buttonText,
    this.padding = 8.0,
    this.color,
    this.fontSize = 16.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: fontSize),
        ),
      ),
      color: color == null ? Color(0xFF10b3e5) : color,
      textColor: Colors.white,
      onPressed: callback,
    );
  }
}
