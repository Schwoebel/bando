import 'package:dartz/dartz.dart';
import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/features/authentication/domain/entities/auth.dart';
import 'package:bando/core/features/authentication/domain/repositories/auth_repository.dart';

class ManageAuth {
  final AuthRepository authRepository;

  ManageAuth(this.authRepository);

  Future<Either<Failure, Auth>> getCurrentUser() async {
    return await authRepository.getCurrentUser();
  }

  Future<Either<Failure, Auth>> createUser(String email, String password) async {
    return await authRepository.createUser(email, password);
  }

  Future<Either<Failure, Auth>> signIn(String email, String password) async {
    return await authRepository.signIn(email, password);
  }

  Future<Either<Failure, Auth>> signOut() async {
    return await authRepository.signOut();
  }
}
