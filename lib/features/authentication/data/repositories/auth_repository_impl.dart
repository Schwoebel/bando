import 'package:bando/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:bando/features/user_details/data/data_sources/user_details_local_data_source.dart';
import 'package:bando/features/user_details/data/data_sources/user_details_remote_data_source.dart';
import 'package:bando/core/failures/exceptions.dart';
import 'package:bando/features/user_details/data/models/user_details.model.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/authentication/domain/entities/auth.dart';
import 'package:bando/features/authentication/domain/entities/user.dart';
import 'package:bando/features/authentication/domain/repositories/auth_repository.dart';
import 'package:bando/core/network/network_info.dart';

typedef Future<Auth> _ProvideAuth();

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final UserDetailsLocalDataSource userDetailsLocalDataSource;
  final UserDetailsRemoteDataSource userDetailsRemoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    @required this.userDetailsLocalDataSource,
    @required this.userDetailsRemoteDataSource,
    @required this.authRemoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, Auth>> getCurrentUser() async {
    return _doAction(() async {
      FirebaseUser firebaseUser = await authRemoteDataSource.getCurrentUser();
      Auth auth = Auth(
          currentUser: firebaseUser == null
              ? throw NoUserException()
              : User.fromFirebase(firebaseUser));
      if (auth.currentUser != null) {
        _alsoGetUserDetails();
      }
      return auth;
    });
  }

  @override
  Future<Either<Failure, Auth>> createUser(
      String email, String password) async {
    return _doAction(
      () async {
        return authRemoteDataSource.createUser(email, password).then(
          (AuthResult result) async {
            final Auth auth = Auth(
              currentUser: User.fromFirebase(result.user),
            );
            return auth;
          },
        );
      },
    );
  }

  @override
  Future<Either<Failure, Auth>> signIn(String email, String password) async {
    return _doAction(() async {
      AuthResult result = await authRemoteDataSource.signIn(email, password);
      final Auth auth = Auth(
        currentUser: User.fromFirebase(result.user),
      );
      if (auth.currentUser != null) {
        _alsoGetUserDetails();
      }
      return auth;
    });
  }

  @override
  Future<Either<Failure, Auth>> signOut() async {
    return _doAction(
      () async {
        return authRemoteDataSource.signOut().then(
          (_) {
            return Auth(
              currentUser: null,
            );
          },
        );
      },
    );
  }

  _alsoGetUserDetails() async {
    UserDetailsModel userDetails =
        await userDetailsRemoteDataSource.getUserDetails();
    try {
      await userDetailsLocalDataSource.saveUserDetails(userDetails);
    } catch (e) {
      throw CacheException();
    }
  }

  Future<Either<Failure, Auth>> _doAction(_ProvideAuth auth) async {
    if (await networkInfo.isConnected) {
      try {
        final authResult = await auth();
        return Right(authResult);
      } on PlatformException catch (e) {
        if (e.code == 'ERROR_USER_NOT_FOUND') {
          return Left(UserNotFoundFailure());
        } else if (e.code == 'ERROR_WRONG_PASSWORD') {
          return Left(WrongPasswordFailure());
        } else {
          return Left(PlatformFailure());
        }
      } on NoUserException {
        return Left(NotLoggedInFailure());
      } catch (e) {
        return Left(UnknownFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
