part of 'view_entries_bloc.dart';

@immutable
abstract class ViewEntriesState extends Equatable {
  final List<dynamic> properties;

  ViewEntriesState({@required this.properties});

  @override
  List<Object> get props => properties;
}

class ViewEntriesEmptyState extends ViewEntriesState {
  ViewEntriesEmptyState() : super(properties: []);
}

class ViewEntriesLoadingState extends ViewEntriesState {
  ViewEntriesLoadingState() : super(properties: []);
}

class ViewEntriesSuccessState extends ViewEntriesState {
  final Stream<List<Entry>> entries;
  final String personOfInterest;

  ViewEntriesSuccessState({
    @required this.entries,
    @required this.personOfInterest,
  }) : super(properties: [entries, personOfInterest]);
}

class ViewEntriesHasError extends ViewEntriesState{
  final String message;

  ViewEntriesHasError(this.message): super(properties: [message]);
}