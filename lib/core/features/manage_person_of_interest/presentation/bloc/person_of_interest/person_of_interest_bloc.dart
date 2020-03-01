import 'dart:async';
import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/core/features/manage_person_of_interest/domain/entities/person_of_interest_entity.dart';

import 'package:baindo/core/features/manage_person_of_interest/domain/use_cases/manage_person_of_interest.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'person_of_interest_event.dart';

part 'person_of_interest_state.dart';

class PersonOfInterestBloc
    extends Bloc<PersonOfInterestEvent, PersonOfInterestState> {
  final ManagePersonOfInterest managePersonOfInterest;

  PersonOfInterestBloc({@required this.managePersonOfInterest})
      : assert(managePersonOfInterest != null);

  @override
  PersonOfInterestState get initialState => InitialPersonOfInterestState();

  @override
  Stream<PersonOfInterestState> mapEventToState(
      PersonOfInterestEvent event) async* {
    yield WaitingOnPersonOfInterestProcess();
    if (event is ReadPersonOfInterestEvent) {
    } else if (event is ReadAllowedPersonsOfInterestEvent) {
      final Either<Failure, List<PersonOfInterest>> result = await managePersonOfInterest.readList();
      yield* _failureOrPersonsOfInterest(result);
    } else if (event is CreatePersonOfInterestEvent) {
    } else if (event is DeletePersonOfInterestEvent) {
    } else if (event is UpdatePersonOfInterestEvent) {
    } else {
      yield InitialPersonOfInterestState();
    }
  }

  Stream<PersonOfInterestState> _failureOrPersonsOfInterest(
      Either<Failure, List<PersonOfInterest>> result) async* {
    yield result.fold(
        (Failure failure) => ErrorWithPersonOfInterestProcess(
            message: _mapFailureToMessage(failure)),
        (entries) =>
            GetAllPersonsOfInterestComplete(personsOfInterest: entries));
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
