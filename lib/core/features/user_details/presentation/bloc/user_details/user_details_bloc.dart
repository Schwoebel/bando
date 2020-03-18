import 'dart:async';
import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/core/features/user_details/domain/entities/user_details.dart';
import 'package:baindo/core/features/user_details/domain/use_cases/manage_user_details.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'user_details_event.dart';

part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  final ManageUserDetails manageUserDetails;

  UserDetailsBloc({
    @required this.manageUserDetails,
  }) : assert(manageUserDetails != null);

  @override
  UserDetailsState get initialState => InitialUserDetailsState();

  @override
  Stream<UserDetailsState> mapEventToState(UserDetailsEvent event) async* {
    if (event is GetUserDetailsEvent) {
      yield Waiting();
      Either<Failure, UserDetails> result = await manageUserDetails(
        UserDetailParameters(),
      );
      yield* _eitherFailureOrSuccess(result);
    }
  }

  Stream<UserDetailsState> _eitherFailureOrSuccess(
    Either<Failure, UserDetails> result,
  ) async* {
    yield result.fold(
      (failure) => ErrorRetrievingUserDetails(
        mapFailureToMessage(failure),
      ),
      (UserDetails success) => UserDetailsRetrieved(userDetails: success),
    );
  }
}
