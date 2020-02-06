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
  final List<Entry> entries;

  ViewEntriesSuccessState({
    @required this.entries,
  }) : super(properties: [entries]);
}

class ViewEntriesHasError extends ViewEntriesState{
  final String message;

  ViewEntriesHasError(this.message): super(properties: [message]);
}