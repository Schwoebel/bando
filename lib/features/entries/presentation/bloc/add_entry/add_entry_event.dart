part of 'add_entry_bloc.dart';

@immutable
abstract class AddEntryEvent extends Equatable{
  final Entry entry;

  AddEntryEvent(this.entry);
}

class CreateEntry extends AddEntryEvent{
  CreateEntry(Entry entry) : super(entry);

  @override
  List<Object> get props => [entry];

}

class UpdateEntry extends AddEntryEvent{
  final Entry updatedEntry;

  UpdateEntry(this.updatedEntry):super(updatedEntry);

  @override
  // TODO: implement props
  List<Object> get props => [updatedEntry];
}

class SaveEntry extends AddEntryEvent{
  final Entry entry;
  final String personOfInterestId;
  SaveEntry(this.entry, this.personOfInterestId) : super(entry);

  @override
  List<Object> get props => [entry];

}

