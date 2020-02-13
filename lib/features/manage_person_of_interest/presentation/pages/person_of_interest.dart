import 'package:flutter/material.dart';

class PersonOfInterest extends StatefulWidget {
  @override
  _PersonOfInterestState createState() => _PersonOfInterestState();
}

class _PersonOfInterestState extends State<PersonOfInterest>
  with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
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
    return Container();
  }
}
