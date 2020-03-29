part of 'view_entries_bloc.dart';

@immutable
abstract class ViewEntriesEvent extends Equatable {
  final List<dynamic> properties;

  ViewEntriesEvent({@required this.properties});

  @override
  List<Object> get props => properties;
}

class LoadEntriesEvent extends ViewEntriesEvent {
  final String personOfInterestId;

  LoadEntriesEvent(this.personOfInterestId)
      : super(
          properties: [personOfInterestId],
        );
}
