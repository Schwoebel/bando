import 'package:flutter/material.dart';

class PersonOfInterestPage extends StatefulWidget {
  @override
  _PersonOfInterestPageState createState() => _PersonOfInterestPageState();
}

class _PersonOfInterestPageState extends State<PersonOfInterestPage>
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
