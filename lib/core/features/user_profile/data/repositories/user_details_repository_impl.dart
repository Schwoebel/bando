import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/core/features/user_profile/data/data_sources/user_details_local_data_source.dart';
import 'package:baindo/core/features/user_profile/data/data_sources/user_details_remote_data_source.dart';
import 'package:baindo/core/features/user_profile/domain/entities/user_details.dart';
import 'package:baindo/core/features/user_profile/domain/repositories/user_details_repository.dart';
import 'package:dartz/dartz.dart';

class UserDetailsRepositoryImpl implements UserDetailsRepository{
  UserDetailsLocalDataSource _userDetailsLocalDataSource;
  UserDetailsRemoteDataSource _userDetailsRemoteDataSource;
  @override
  Future<Either<Failure, UserDetails>> getUserDetails() {
    // TODO: implement getUserDetails
    return null;
  }

  @override
  Future<Either<Failure, UserDetails>> updateUserDetails() {
    // TODO: implement updateUserDetails
    return null;
  }
}