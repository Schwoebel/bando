part of 'input_field_bloc.dart';

@immutable
abstract class InputFieldState {}

class InitialInputFieldState extends InputFieldState {}

class HasValue extends InputFieldState{
  final String text;

  HasValue({@required this.text});
}

class HasValidValue extends InputFieldState{}

class HasError extends InputFieldState{}