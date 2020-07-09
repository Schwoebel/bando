import 'dart:async';

import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/use_cases/management_use_case.dart';
import 'package:bando/core/use_cases/use_cases.dart';
import 'package:bando/features/person_of_interest/domain/entities/person_of_interest_entity.dart';
import 'package:bando/features/person_of_interest/domain/repositories/person_of_interest_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class PersonOfInterestParams extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class PersonOfInterestManager
    extends ManagementUseCase<PersonOfInterest, CRUDParams> {
  final PersonOfInterestRepository personOfInterestRepository;

  PersonOfInterestManager({@required this.personOfInterestRepository});

  @override
  Future<Either<Failure, PersonOfInterest>> create(CreateParams params) async {
    return await personOfInterestRepository.create();
  }

  @override
  Future<Either<Failure, bool>> delete(
      DeleteParams<String> params) async {
    return await personOfInterestRepository.delete(personOfInterestId: params.objectToDelete);
  }

  @override
  Future<Either<Failure, PersonOfInterest>> read(ReadParams params) async{
    return await personOfInterestRepository.read(id: params.objectId);
  }

  @override
  Future<Either<Failure, PersonOfInterest>> update(
      UpdateParams<String, PersonOfInterest> params) async {
    return await personOfInterestRepository.update(
      id: params.objectToUpdateId,
      person: params.objectToUpdate,
    );
  }

  @override
  Future<Either<Failure, List<PersonOfInterest>>> readAll() async {
    return await personOfInterestRepository.readList();
  }
}

class PersonOfInterestCreateParams extends CreateParams<PersonOfInterest> {
  PersonOfInterestCreateParams(PersonOfInterest objectToCreate)
      : super(objectToCreate);

  @override
  List<Object> get props => [objectToCreate];

  @override
  bool get stringify => true;
}

class PersonOfInterestReadParams extends ReadParams<String> {
  PersonOfInterestReadParams(String personOfInterestId)
      : super(personOfInterestId);

  @override
  List<Object> get props => [objectId];

  @override
  bool get stringify => true;
}

class PersonOfInterestUpdateParams
    extends UpdateParams<String, PersonOfInterest> {
  PersonOfInterestUpdateParams(
    String objectToUpdateId,
    PersonOfInterest objectToUpdate,
  ) : super(
          objectToUpdateId,
          objectToUpdate,
        );

  @override
  // TODO: implement props
  List<Object> get props => [objectToUpdateId, objectToUpdate];

  @override
  bool get stringify => true;
}

class PersonOfInterestDeleteParams extends DeleteParams<String> {
  PersonOfInterestDeleteParams(String objectToDelete) : super(objectToDelete);

  @override
  List<Object> get props => [objectToDelete];

  @override
  bool get stringify => true;
}
