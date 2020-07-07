part of 'sign_in_form_bloc.dart';

@immutable
abstract class SignInFormState {
  final String email;
  final String password;

  SignInFormState({@required this.email, @required this.password});
}

class InitialSignInFormState extends SignInFormState {
  InitialSignInFormState() : super(email: '', password: '');
}

class CanSignIn extends SignInFormState {
  CanSignIn({@required String email, @required String password})
      : super(
          email: email,
          password: password,
        );
}
