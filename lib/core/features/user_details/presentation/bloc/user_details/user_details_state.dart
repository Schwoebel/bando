part of 'user_details_bloc.dart';

@immutable
abstract class UserDetailsState {}

class InitialUserDetailsState extends UserDetailsState {}

class Waiting extends UserDetailsState {}

class ErrorRetrievingUserDetails extends UserDetailsState{
  final String message;

  ErrorRetrievingUserDetails(this.message);
}

class UserDetailsRetrieved extends UserDetailsState{
  final UserDetails userDetails;

  UserDetailsRetrieved({@required this.userDetails});
}