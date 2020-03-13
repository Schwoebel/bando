import 'package:baindo/core/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:baindo/core/features/authentication/presentation/widgets/sign_in_form.dart';
import 'package:baindo/features/view_entries/presentation/pages/view_entries_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        bloc: BlocProvider.of<AuthBloc>(context),
        builder: (context, AuthState state) {
          return SignInForm();
        },
      ),
    );
  }
}
