import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/use_cases/use_cases.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../entities/user_details.dart';
import '../repositories/user_details_repository.dart';

class  ManageUserDetails extends UseCase<UserDetails, UserDetailParameters> {
  final UserDetailsRepository repository;

  ManageUserDetails({
    @required this.repository,
  });

  @override
  Future<Either<Failure, UserDetails>> call(UserDetailParameters params) {
    return repository.getUserDetails();
  }

  Future<Either<Failure, UserDetails>> update(UserDetailParameters params) {
    return repository.updateUserDetails(params.details);
  }
}

class UserDetailParameters extends Equatable {
  final UserDetails details;

  UserDetailParameters(this.details);
  @override
  List<Object> get props => [details];
}
