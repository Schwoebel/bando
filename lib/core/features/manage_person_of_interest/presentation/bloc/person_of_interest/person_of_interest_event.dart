part of 'person_of_interest_bloc.dart';

@immutable
abstract class PersonOfInterestEvent extends Equatable {
  final List<dynamic> properties;

  PersonOfInterestEvent({@required this.properties});

  @override
  List<Object> get props => properties;
}

class ReadPersonOfInterestEvent extends PersonOfInterestEvent {
  final String id;

  ReadPersonOfInterestEvent({@required this.id}) : super(properties: [id]);
}

class ReadAllowedPersonsOfInterestEvent extends PersonOfInterestEvent {}

class CreatePersonOfInterestEvent extends PersonOfInterestEvent {
  final PersonOfInterest person;

  CreatePersonOfInterestEvent({@required this.person})
      : super(properties: [person]);
}

class DeletePersonOfInterestEvent extends PersonOfInterestEvent {
  final String id;

  DeletePersonOfInterestEvent({@required this.id}) : super(properties: [id]);
}

class UpdatePersonOfInterestEvent extends PersonOfInterestEvent {
  final String id;
  final PersonOfInterest person;

  UpdatePersonOfInterestEvent({
    @required this.id,
    @required this.person,
  }) : super(properties: [
          id,
          person,
        ]);
}
