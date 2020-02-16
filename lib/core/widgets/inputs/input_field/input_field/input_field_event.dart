part of 'input_field_bloc.dart';

@immutable
abstract class InputFieldEvent {}

class ValueEntered extends InputFieldEvent{
  final String value;
  ValueEntered({@required this.value});
}
