import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/core/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:baindo/core/features/authentication/domain/entities/auth.dart';
import 'package:baindo/core/features/authentication/domain/entities/user.dart';
import 'package:baindo/core/features/authentication/domain/repositories/auth_repository.dart';
import 'package:baindo/core/network/network_info.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    @required this.authRemoteDataSource,
    @required this.networkInfo,
  });

  Either<Failure, Auth> handleException(Object exception) {
    if (exception is PlatformException) {
      final Auth auth = Auth(
        currentUser: null,
        code: exception.code,
        message: exception.message,
      );

      return Right(auth);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> getCurrentUser() async {
    if (await networkInfo.isConnected) {
      try {
        FirebaseUser firebaseUser = await authRemoteDataSource.getCurrentUser();
        Auth auth = Auth(
            currentUser:
                firebaseUser == null ? null : User.fromFirebase(firebaseUser));
        return Right(auth);
      } catch (e) {
        handleException(e);
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> createUser(
      String email, String password) async {
    if (await networkInfo.isConnected) {
      // Todo check if valid email maybe
      return authRemoteDataSource
          .createUser(email, password)
          .then((AuthResult result) async {
        final Auth auth = Auth(
          currentUser: User.fromFirebase(result.user),
        );

        return Right<Failure, Auth>(auth);
      }).catchError(handleException);
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> signIn(String email, String password) async {
    if (await networkInfo.isConnected) {
      try{
        return authRemoteDataSource
          .signIn(email, password)
          .then((AuthResult result) async {
          final Auth auth = Auth(
            currentUser: User.fromFirebase(result.user),
          );

          return Right<Failure, Auth>(auth);
        }).catchError(handleException);
      } catch (e){
        print(e);
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Auth>> signOut() async {
    if (await networkInfo.isConnected) {
      return authRemoteDataSource.signOut().then((_) {
        final Auth auth = Auth(
          currentUser: null,
        );

        return Right<Failure, Auth>(auth);
      }).catchError(handleException);
    } else {
      return Left(NetworkFailure());
    }
  }
}
