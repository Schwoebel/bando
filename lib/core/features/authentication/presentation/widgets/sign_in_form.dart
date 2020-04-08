import 'package:bando/core/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:bando/core/features/authentication/presentation/bloc/sign_in_form/sign_in_form_bloc.dart';
import 'package:bando/core/features/authentication/presentation/widgets/header_logo.dart';
import 'package:bando/core/theme/bando_theme.dart';
import 'package:bando/core/widgets/buttons/long_input_button.dart';
import 'package:bando/core/widgets/inputs/input_field/password_field.dart';
import 'package:bando/core/widgets/inputs/email_input_field/email_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_user.dart';

class SignInForm extends StatefulWidget {
  SignInForm({Key key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInFormBloc>(
      create: (BuildContext context) => SignInFormBloc(),
      child: BlocConsumer<SignInFormBloc, SignInFormState>(
        listener: (BuildContext context, SignInFormState state) {},
        builder: (BuildContext context, SignInFormState state) {
          return _loginFormLayoutBuilder();
        },
      ),
    );
  }

  Widget _loginFormLayoutBuilder() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: HeaderLogo(),
                    ),
                    Expanded(
                      child: _formFields(),
                    ),
                    Expanded(child: _formButtons())
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _formFields() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _emailField(),
          _spacer(32.0),
          _passwordField(),
        ],
      ),
    );
  }

  Widget _formButtons() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _createUserButton(),
          _spacer(12),
          _loginButton(),
        ],
      ),
    );
  }

  Widget _emailField() {
    return EmailInputField(
      onSavedCallback: (String value) {
        email = value;
      },
    );
  }

  Widget _passwordField() {
    return PasswordField(
      onSavedCallback: (value) {
        password = value;
      },
    );
  }

  Widget _loginButton() {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          "LOGGA IN",
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      color: Color(0xFF10b3e5),
      textColor: Colors.white,
      onPressed: () => otherValidation(),
    );
  }

  Widget _createUserButton() {
    return LongInputButton(
      padding: 12.0,
      fontSize: 24.0,
      buttonText: 'SKAPA KONTO',
      color: Color(0xFFc2e59c),
      callback: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateUser(),
          ),
        );
      },
    );
  }

  Widget _spacer(double height) {
    return SizedBox(
      height: height,
    );
  }

  void otherValidation() {
    if (_formKey.currentState.validate()) {
      // If the form is valid, display a snackbar. In the real world,
      // you'd often call a server or save the information in a database.
      BlocProvider.of<AuthBloc>(context).add(SignInEvent(
        email: email,
        password: password,
      ));
    }
  }
}
