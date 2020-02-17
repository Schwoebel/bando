import 'package:baindo/core/widgets/inputs/email_input_field/bloc/email_input_field_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

class EmailInputField extends StatefulWidget {
  final Function callback;
  final String hintText;
  final String errorText;

  EmailInputField(
      {Key key,
      @required this.callback,
      @required this.hintText,
      @required this.errorText})
      : super(key: key);

  @override
  _EmailInputFieldState createState() => _EmailInputFieldState();
}

class _EmailInputFieldState extends State<EmailInputField> {
  EmailInputFieldBloc bloc;
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
  void didChangeDependencies() {
    bloc = EmailInputFieldBloc();
    _controller.addListener(_onChanged);
    super.didChangeDependencies();
  }

  void _onChanged() {
    bloc.add(
      ValueEntered(value: _controller.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmailInputFieldBloc, EmailInputFieldState>(
      bloc: bloc,
      builder: (BuildContext context, EmailInputFieldState state) {
        //if(state is HasValidValue) widget.callback();
        return TextFormField(
          controller: _controller,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            errorText: state is HasError ? widget.errorText : '',
            hintText: widget.hintText,
            fillColor: Colors.white,
            filled: true,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
            //
          ),
        );
      },
    );
  }
}
