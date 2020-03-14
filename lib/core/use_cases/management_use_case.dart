import 'package:baindo/core/failures/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class ManagementUseCase<Type, EntryParams>{
  Future<Either<Failure, bool>> create(EntryParams params);
  Future<Either<Failure, Type>> read(EntryParams params);
  Future<Either<Failure, bool>> update(EntryParams params);
  Future<Either<Failure, bool>> delete(EntryParams params);
}

class NoParams extends Equatable{
  @override
  // TODO: implement props
  List<Object> get props => null;

}