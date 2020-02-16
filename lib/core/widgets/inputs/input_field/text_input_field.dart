import 'package:baindo/core/widgets/inputs/input_field/input_field/input_field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class TextInputField extends StatefulWidget {
  final Function callback;
  final String hintText;
  final String errorText;

  TextInputField(
      {Key key,
      @required this.callback,
      @required this.hintText,
      @required this.errorText})
      : super(key: key);

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  InputFieldBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = InputFieldBloc();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputFieldBloc, InputFieldState>(
      bloc: bloc,
      builder: (BuildContext context, InputFieldState state) {
        return TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              errorText: widget.errorText,
              hintText: widget.hintText,
              fillColor: Colors.white,
              filled: true,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
              //
            ),
            onChanged: (String text) => bloc.add(ValueEntered(value: text)));
      },
    );
  }
}
