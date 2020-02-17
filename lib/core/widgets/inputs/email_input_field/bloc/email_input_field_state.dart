part of 'email_input_field_bloc.dart';

@immutable
abstract class EmailInputFieldState {
  final String text;

  EmailInputFieldState({@required this.text});
}

class InitialInputFieldState extends EmailInputFieldState {}

class HasValue extends EmailInputFieldState {
  HasValue({@required value})
      : super(
          text: value,
        );
}

class HasValidValue extends EmailInputFieldState {}

class HasError extends EmailInputFieldState {}
