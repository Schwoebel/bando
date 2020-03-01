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
  AuthBloc authBloc;

  @override
  didChangeDependencies() {
    BlocProvider.of<AuthBloc>(context)
      //..add(SignOutEvent())
      ..add(GetCurrentUserEvent());
    super.didChangeDependencies();
  }

  _reRouteIfLoggedIn() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, '/soundboard');
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, AuthState state){
        if (state is Loaded && state.auth.currentUser != null) {
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => ViewEntriesPage()));
          return SizedBox();
        } else {
          return Scaffold(body: SignInForm());
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        bloc: BlocProvider.of<AuthBloc>(context),
        builder: (context, AuthState state) {
          if (state is Loading) {
            return Container(
              child: Center(
                child: Text('State Loading'),
              ),
            );
          } else if (state is Loaded || state is Empty) {
            if (state is Loaded && state.auth.currentUser != null) {
              return SizedBox();
            } else {
              return Scaffold(body: SignInForm());
            }
          } else {
            return Container(
              child: Center(
                child: Text('AuthState Error'),
              ),
            );
          }
        },
      ),
    );
  }
}
