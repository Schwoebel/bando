import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/person_of_interest/domain/entities/person_of_interest_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class ManagementUseCase<Type, CRUDParams>{
  Future<Either<Failure, Type>> create(CreateParams params);
  Future<Either<Failure, Type>> read(ReadParams<Type> params);
  Future<Either<Failure, List<Type>>> readAll();
  Future<Either<Failure, Type>> update(UpdateParams<String, Type> params);
  Future<Either<Failure, bool>> delete(DeleteParams<Type> params);
}

abstract class CRUDParams extends Equatable{}

abstract class CreateParams<Type> implements CRUDParams{
  final Type objectToCreate;

  CreateParams(this.objectToCreate);
}

abstract class ReadParams<String> implements CRUDParams{
  final String objectId;

  ReadParams(this.objectId);
}

abstract class UpdateParams<String, Type> implements CRUDParams{
  final String objectToUpdateId;
  final Type objectToUpdate;

  UpdateParams(this.objectToUpdateId, this.objectToUpdate);
}

abstract class DeleteParams<Type> implements CRUDParams{
    final Type objectToDelete;

  DeleteParams(this.objectToDelete);
}