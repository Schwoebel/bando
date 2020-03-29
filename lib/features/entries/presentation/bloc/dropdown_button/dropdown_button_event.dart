part of 'dropdown_button_bloc.dart';

@immutable
abstract class DropdownButtonEvent {}


class ChangeValueEvent extends DropdownButtonEvent{
  final dynamic newValue;

  ChangeValueEvent({@required this.newValue});

}