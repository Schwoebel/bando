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

class SaveEntry extends AddEntryEvent{
  SaveEntry(Entry entry) : super(entry);

  @override
  List<Object> get props => [entry];

}

