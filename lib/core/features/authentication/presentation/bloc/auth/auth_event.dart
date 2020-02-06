part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {
  final List<dynamic> properties;

  AuthEvent(this.properties) : super();

  @override
  // TODO: implement props
  List<Object> get props => properties;
}

class GetCurrentUserEvent extends AuthEvent {
  GetCurrentUserEvent() : super([]);
}

class CreateUserEvent extends AuthEvent {
  final String email;
  final String password;

  CreateUserEvent({
    @required this.email,
    @required this.password,
  }) : super([]);
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({
    @required this.email,
    @required this.password,
  }) : super([]);
}

class SignOutEvent extends AuthEvent {
  SignOutEvent() : super([]);
}
