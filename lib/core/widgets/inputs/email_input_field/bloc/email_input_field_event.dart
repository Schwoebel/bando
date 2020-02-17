part of 'email_input_field_bloc.dart';

@immutable
abstract class EmailInputFieldEvent {}

class ValueEntered extends EmailInputFieldEvent {
  final String value;

  ValueEntered({@required this.value});
}

class ValidValueEntered extends EmailInputFieldEvent {
  final String value;
  final bool valid;

  ValidValueEntered({
    @required this.value,
    @required this.valid,
  });
}
