part of 'sign_in_form_bloc.dart';

@immutable
abstract class SignInFormEvent {
  final String password;
  final String email;

  SignInFormEvent({this.password = '', this.email= ''});
}
class AddPasswordData extends SignInFormEvent{
  final String password;

  AddPasswordData(this.password);
}

class AddEmailData extends SignInFormEvent{
  final String email;
  AddEmailData(this.email);
}