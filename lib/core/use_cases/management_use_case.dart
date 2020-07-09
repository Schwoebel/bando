import 'package:bando/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class ManagementUseCase<Type, CRUDParams>{
  Future<Either<Failure, Type>> create(CreateParams<Type> params);
  Future<Either<Failure, Type>> read(ReadParams<Type> params);
  Future<Either<Failure, List<Type>>> readAll();
  Future<Either<Failure, Type>> update(UpdateParams<String, Type> params);
  Future<Either<Failure, bool>> delete(DeleteParams<String> params);
}

abstract class CRUDParams extends Equatable{}

abstract class CreateParams<Type> implements CRUDParams{
  final Type objectToCreate;
  final String parentId;
  CreateParams(this.objectToCreate,{this.parentId});
}

abstract class ReadParams<String> implements CRUDParams{
  final String objectId;
  final String parentId;
  ReadParams(this.objectId, {this.parentId});
}

abstract class UpdateParams<String, Type> implements CRUDParams{
  final String objectToUpdateId;
  final Type objectToUpdate;
  final String parentId;
  UpdateParams(this.objectToUpdateId, this.objectToUpdate, {this.parentId});
}

abstract class DeleteParams<Type> implements CRUDParams{
    final Type objectToDelete;
    final String parentId;
  DeleteParams(this.objectToDelete, {this.parentId});
}