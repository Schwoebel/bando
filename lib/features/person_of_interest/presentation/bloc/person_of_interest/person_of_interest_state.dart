part of 'person_of_interest_bloc.dart';

@immutable
abstract class PersonOfInterestState extends Equatable {
  final List<dynamic> properties;

  PersonOfInterestState({@required this.properties});

  @override
  // TODO: implement props
  List<Object> get props => properties;
}

class InitialPersonOfInterestState extends PersonOfInterestState {}

class WaitingOnPersonOfInterestProcess extends PersonOfInterestState {}

class DeletePersonOfInterestComplete extends PersonOfInterestState {}

class GetAllPersonsOfInterestComplete extends PersonOfInterestState {
  final List<PersonOfInterest> personsOfInterest;

  GetAllPersonsOfInterestComplete({@required this.personsOfInterest})
      : super(properties: [personsOfInterest]);
}

class GetPersonOfInterestComplete extends PersonOfInterestState {}

class ErrorWithPersonOfInterestProcess extends PersonOfInterestState {
  final String message;
  ErrorWithPersonOfInterestProcess({@required this.message});
}
