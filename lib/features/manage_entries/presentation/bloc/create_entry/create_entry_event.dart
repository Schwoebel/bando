part of 'create_entry_bloc.dart';

@immutable
abstract class CreateEntryEvent {}

class UpdateEntry extends CreateEntryEvent {
  final Entry entry;
  UpdateEntry({@required this.entry});
}

class CreateEntry extends CreateEntryEvent {
  final Entry newEntry = Entry('', 0, '');
  CreateEntry();
}

class InitializeEntryEvent extends CreateEntryEvent {}

class SaveEntryOnRemoteEvent extends CreateEntryEvent {}
