import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/user_details/domain/entities/user_details.dart';
import 'package:dartz/dartz.dart';

abstract class UserDetailsRepository{
  Future<Either<Failure, UserDetails>> getUserDetails();
  Future<Either<Failure, UserDetails>> updateUserDetails(UserDetails userDetails);
}