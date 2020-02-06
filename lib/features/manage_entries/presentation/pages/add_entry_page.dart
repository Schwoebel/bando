import 'package:flutter/material.dart';

class AddEntryPage extends StatefulWidget {
  final String personOfInterest;

  const AddEntryPage({Key key, this.personOfInterest}) : super(key: key);

  @override
  _AddEntryPageState createState() => _AddEntryPageState();
}

class _AddEntryPageState extends State<AddEntryPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _entryController = TextEditingController();
  String defaultMood = 'Happy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              DropdownButton<String>(
                value: defaultMood,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    defaultMood = newValue;
                  });
                },
                items: <String>[
                  'Happy',
                  'Sad',
                  'Tired',
                  'Excited',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              TextFormField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                controller: _entryController,
              ),
              RaisedButton(
                child: Text('Submit'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.chevron_left),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
