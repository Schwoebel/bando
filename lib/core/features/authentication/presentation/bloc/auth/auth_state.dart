part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  final List<dynamic> properties;

  AuthState(this.properties);

  @override
  List<Object> get props => properties;
}

class Empty extends AuthState {
  Empty({List properties}) : super([properties]);
}

class Loading extends AuthState {
  Loading({List properties}) : super(properties);
}

class Loaded extends AuthState {
  final Auth auth;

  Loaded({@required this.auth}) : super([auth]);
}

class Error extends AuthState {
  final String message;

  Error( this.message) : super([message]);
}
