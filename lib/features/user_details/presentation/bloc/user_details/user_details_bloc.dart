import 'dart:async';
import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/user_details/domain/entities/user_details.dart';
import 'package:bando/features/user_details/domain/use_cases/manage_user_details.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/widgets.dart';

part 'user_details_state.dart';
part 'user_details_event.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final ManageUserDetails manageUserDetails;

  UserDetailsBloc({
    @required this.manageUserDetails,
  }) : assert(manageUserDetails != null), super(InitialUserDetailsState());

  @override
  Stream<UserDetailsState> mapEventToState(UserDetailsEvent event) async* {
    if (event is GetUserDetailsEvent) {
      yield Waiting();
      Either<Failure, UserDetails> result = await manageUserDetails(
        UserDetailParameters(null),
      );
      yield* _eitherFailureOrSuccess(result);
    } else if (event is UpdateUserDetails) {
      yield* _updateUserDetails(event.updatedUserDetails);
    }
  }

  Stream<UserDetailsState> _eitherFailureOrSuccess(
    Either<Failure, UserDetails> result, {bool fromUpdate = false}
  ) async* {
    yield result.fold(
      (failure) => ErrorRetrievingUserDetails(
        mapFailureToMessage(failure),
      ),
      (UserDetails success) => UserDetailsRetrieved(userDetails: success, fromUpdate: fromUpdate),
    );
  }

  Stream<UserDetailsState> _updateUserDetails(UserDetails updatedUserDetails) async* {
    UserDetails userDetails = updatedUserDetails
      .copyWith(authors: updatedUserDetails.authors);
    var result = await manageUserDetails.update(UserDetailParameters(userDetails));
    yield* _eitherFailureOrSuccess(result, fromUpdate: true);
  }
}
