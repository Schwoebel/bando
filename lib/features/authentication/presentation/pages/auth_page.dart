import 'package:bando/features/authentication/presentation/bloc/auth/auth_bloc.dart';
import 'package:bando/features/authentication/presentation/widgets/sign_in_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey loadingKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (BuildContext context, AuthState state){
          if (state is Error) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
            ));
          } else if (state is SigningIn) {
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("Authenticating"),
            ));
          } else if(state is Loaded || state is Empty){
          }
        },
        builder: (
          BuildContext context,
          AuthState state,
        ) {
          return Container(
            decoration: _authPageContainerBoxDecoration(),
            child: SignInForm(),
          );
        },
      ),
    );
  }



  BoxDecoration _authPageContainerBoxDecoration() {
    return BoxDecoration(
      image: DecorationImage(
          colorFilter: ColorFilter.mode(Colors.pinkAccent[100], BlendMode.lighten),
          image: AssetImage('assets/images/login_background.jpg'),
          fit: BoxFit.cover),
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFFc2e59c),
          Color(0xFF64b3f4),
        ],
      ),
    );
  }
}
