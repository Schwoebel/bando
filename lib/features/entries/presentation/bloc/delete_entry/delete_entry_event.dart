part of 'delete_entry_bloc.dart';

@immutable
abstract class DeleteEntryEvent implements Equatable{}

class Delete implements DeleteEntryEvent{
  final String poiID;
  final String entryID;

  Delete(this.poiID, this.entryID);
  @override
  // TODO: implement props
  List<Object> get props => null;

  @override
  // TODO: implement stringify
  bool get stringify => null;
}