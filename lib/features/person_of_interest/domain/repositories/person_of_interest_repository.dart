import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/person_of_interest/domain/entities/person_of_interest_entity.dart';

import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

abstract class PersonOfInterestRepository {
  Future<Either<Failure, PersonOfInterest>> create();

  Future<Either<Failure, PersonOfInterest>> read({@required String id});

  Future<Either<Failure, List<PersonOfInterest>>> readList();

  Future<Either<Failure, PersonOfInterest>> update({
    @required String id,
    @required PersonOfInterest person,
  });

  Future<Either<Failure, bool>> delete({@required PersonOfInterest personOfInterest});
}
