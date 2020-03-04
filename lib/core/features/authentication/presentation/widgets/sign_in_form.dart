import 'package:baindo/core/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:baindo/core/features/authentication/presentation/bloc/sign_in_form/sign_in_form_bloc.dart';
import 'package:baindo/core/widgets/buttons/long_input_button.dart';
import 'package:baindo/core/widgets/inputs/input_field/password_field.dart';
import 'package:baindo/core/widgets/inputs/email_input_field/email_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'create_user.dart';

class SignInForm extends StatefulWidget {
  SignInForm({Key key}) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInFormBloc>(
      create: (BuildContext context) => SignInFormBloc(),
      child: BlocBuilder<SignInFormBloc, SignInFormState>(
          builder: (BuildContext context, SignInFormState state) {
        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFFc2e59c),
                  Color(0xFF64b3f4),
                ],
              ),
            ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Image.network(
                      "http://placehold.it/250x150/baindo.png?text=Bando"),
                ),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    child: Column(
                      children: <Widget>[
                        EmailInputField(
                          hintText: "E-mail address",
                          errorText: 'Must be an email',
                          callback: (value) {
                            BlocProvider.of<SignInFormBloc>(context).add(
                              AddEmailData(value),
                            );
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        PasswordField(
                          callback: (value) {
                            BlocProvider.of<SignInFormBloc>(context)
                                .add(AddPasswordData(value));
                          },
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        LongInputButton(
                          buttonText: 'Sign In',
                          callback: _canTrySignIn(state),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        LongInputButton(
                          buttonText: 'Create User',
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateUser(),
                              ),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        );
      }),
    );
  }

  Function _canTrySignIn(SignInFormState state) {
    if (state is CanSignIn) {
      return () => BlocProvider.of<AuthBloc>(context).add(SignInEvent(
        email: state.email,
        password: state.password,
      ));
    } else {
      return null;
    }
  }
}
