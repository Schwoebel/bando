import 'package:bando/core/theme/bando_theme.dart';
import 'package:flutter/material.dart';

class AddPersonOfInterest extends StatefulWidget {
  AddPersonOfInterest({Key key}) : super(key: key);

  @override
  _AddPersonOfInterestState createState() => _AddPersonOfInterestState();
}

class _AddPersonOfInterestState extends State<AddPersonOfInterest> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _poiNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _poiNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Journal'),
      ),
      body: Container(
          padding: EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: BandoColors.blue[400], width: 2.0)),
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        '''ComingSoon: Adding a journal will let you invite users to participate. Adding users will invite those without an account and add this journal to current users journal page. Please consult the people you add before you add them here to make sure if they interested and have permission to use a tool like this app'''),
                  ),
                  TextFormField(
                    controller: _poiNameController,
                    decoration: InputDecoration(labelText: "Initials"),
                  )
                ],
              ))),
    );
  }
}
