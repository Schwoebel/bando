import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/core/features/user_profile/domain/entities/user_details.dart';
import 'package:dartz/dartz.dart';

abstract class UserDetailsRepository{
  Future<Either<Failure, UserDetails>> getUserDetails();
  Future<Either<Failure, UserDetails>> updateUserDetails();
}