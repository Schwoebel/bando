part of 'sign_in_form_bloc.dart';

@immutable
abstract class SignInFormEvent {}

class EmailEnteredEvent extends SignInFormEvent{
  final String email;

  EmailEnteredEvent({@required this.email});
}

class PasswordEnteredEvent extends SignInFormEvent{
  final String password;

  PasswordEnteredEvent({@required this.password});
}
