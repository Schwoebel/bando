import 'dart:async';

import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/core/features/manage_person_of_interest/domain/entities/person_of_interest_entity.dart';
import 'package:baindo/core/features/manage_person_of_interest/domain/repositories/person_of_interest_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class ManagePersonOfInterest {
  final PersonOfInterestRepository personOfInterestRepository;

  ManagePersonOfInterest({@required this.personOfInterestRepository});

  Future<Either<Failure, List<PersonOfInterest>>> readList() async {
    return await personOfInterestRepository.readList();
  }

  Future<Either<Failure, PersonOfInterest>> read(String id) async {
    return await personOfInterestRepository.read(id: id);
  }

  Future<Either<Failure, PersonOfInterest>> create(
      PersonOfInterest person) async {
    return await personOfInterestRepository.create();
  }

  Future<Either<Failure, PersonOfInterest>> update(
      String id, PersonOfInterest person) async {
    return await personOfInterestRepository.update(id: id, person: person);
  }

  Future<Either<Failure, bool>> delete(String id) async {
    return await personOfInterestRepository.delete(id: id);
  }
}

class PersonOfInterestParams extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
