import 'dart:convert';

import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/features/user_details/data/data_sources/user_details_local_data_source.dart';
import 'package:bando/core/features/user_details/data/data_sources/user_details_remote_data_source.dart';
import 'package:bando/core/features/user_details/data/models/user_details.model.dart';
import 'package:bando/core/features/user_details/domain/entities/user_details.dart';
import 'package:bando/core/features/user_details/domain/repositories/user_details_repository.dart';
import 'package:bando/core/network/network_info.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

class UserDetailsRepositoryImpl implements UserDetailsRepository {
  final UserDetailsLocalDataSource userDetailsLocalDataSource;
  final UserDetailsRemoteDataSource userDetailsRemoteDataSource;
  final NetworkInfo networkInfo;

  UserDetailsRepositoryImpl({
    @required this.userDetailsLocalDataSource,
    @required this.userDetailsRemoteDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserDetails>> getUserDetails() async {
    if (await networkInfo.isConnected) {
      try {
        var result = await userDetailsRemoteDataSource.getUserDetails();
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserDetails>> updateUserDetails(
    UserDetails userDetails,
  ) async {
    Map<dynamic, dynamic> userDetailsMap = userDetails.toMap();
    UserDetailsModel userDetailsModel = UserDetailsModel.fromJson(userDetailsMap);
    if (await networkInfo.isConnected) {
      try {
        await userDetailsLocalDataSource.saveUserDetails(userDetailsModel);
        bool success = await userDetailsRemoteDataSource.updateUserDetails(userDetailsModel);
        if(success){
          return Right(userDetailsModel);
        } else {
          return Left(NetworkFailure());
        }

      } catch (e) {
        return Left(NetworkFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
