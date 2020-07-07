part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class Empty extends AuthState {
  Empty() : super();

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class Loading extends AuthState {
  Loading();

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class SigningIn extends AuthState {
  SigningIn();


  @override
  // TODO: implement props
  List<Object> get props => null;}

class Loaded extends AuthState {
  final Auth auth;

  Loaded({@required this.auth});

  @override
  // TODO: implement props
  List<Object> get props => [auth];
}

class Error extends AuthState {
  final String message;

  Error(this.message) : super();

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class UserNotFoundError extends Error {
  UserNotFoundError() : super('User not found');

  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PasswordWrongError extends Error {
  PasswordWrongError() : super("Wrong Password");

  @override
  // TODO: implement props
  List<Object> get props => null;
}
