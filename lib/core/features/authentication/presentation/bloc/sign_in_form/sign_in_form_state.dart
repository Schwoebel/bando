part of 'sign_in_form_bloc.dart';

@immutable
abstract class SignInFormState {
  final String email;
  final String password;

  SignInFormState({@required this.email, @required this.password});
}

class InitialSignInFormState extends SignInFormState {}

class CanTrySignIn extends SignInFormState {}