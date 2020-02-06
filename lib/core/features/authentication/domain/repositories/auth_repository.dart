import 'package:dartz/dartz.dart';
import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/core/features/authentication/domain/entities/auth.dart';

abstract class AuthRepository {

  Future<Either<Failure, Auth>> getCurrentUser();

  Future<Either<Failure, Auth>> createUser(String email, String password);

  Future<Either<Failure, Auth>> signIn(String email, String password);

  Future<Either<Failure, Auth>> signOut();
}
