part of 'user_details_bloc.dart';

@immutable
abstract class UserDetailsState {}

class InitialUserDetailsState extends UserDetailsState {}

class Waiting extends UserDetailsState {}

class ErrorRetrievingUserDetails extends UserDetailsState {
  final String message;

  ErrorRetrievingUserDetails(this.message);
}

class UserDetailsUpdated extends UserDetailsState {
  final UserDetails userDetails;

  UserDetailsUpdated(this.userDetails);
}

class UserDetailsRetrieved extends UserDetailsState {
  final UserDetails userDetails;
  final bool fromUpdate;

  UserDetailsRetrieved({
    @required this.userDetails,
    this.fromUpdate = false,
  });
}
