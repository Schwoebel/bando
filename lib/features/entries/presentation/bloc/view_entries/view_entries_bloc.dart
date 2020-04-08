import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/entries/domain/entities/entry.dart';
import 'package:bando/features/entries/domain/use_cases/get_entries.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'view_entries_event.dart';

part 'view_entries_state.dart';

class ViewEntriesBloc extends Bloc<ViewEntriesEvent, ViewEntriesState>{
  final GetEntries getEntries;

  ViewEntriesBloc({@required this.getEntries});

  @override
  ViewEntriesState get initialState => ViewEntriesEmptyState();

  @override
  Stream<ViewEntriesState> mapEventToState(ViewEntriesEvent event) async* {
    if(event is LoadEntriesEvent){
      final result = await getEntries(Params(event.personOfInterestId));
      yield* _eitherLoadedOrErrorState(result, event.personOfInterestId);
    } else {
      yield ViewEntriesEmptyState();
    }
  }

  Stream<ViewEntriesState> _eitherLoadedOrErrorState(
    Either<Failure, Stream<List<Entry>>> failureOrEntries,
    String personOfInterest
    ) async* {
    yield failureOrEntries.fold(
        (failure) => ViewEntriesHasError(_mapFailureToMessage(failure)),
        (entries) => ViewEntriesSuccessState(entries: entries, personOfInterest: personOfInterest),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}