import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/core/data_sources/user_details_local_data_source.dart';
import 'package:baindo/core/data_sources/user_details_remote_data_source.dart';
import 'package:baindo/core/features/user_details/domain/entities/user_details.dart';
import 'package:baindo/core/features/user_details/domain/repositories/user_details_repository.dart';
import 'package:baindo/core/network/network_info.dart';
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
  Future<Either<Failure, UserDetails>> updateUserDetails() {
    // TODO: implement updateUserDetails
    return null;
  }
}
