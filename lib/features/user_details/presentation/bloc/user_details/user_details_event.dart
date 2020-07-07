part of 'user_details_bloc.dart';





@immutable
abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();
}

class GetUserDetailsEvent extends UserDetailsEvent {
  @override
  // TODO: implement prop
  List<Object> get props => null;
}

class UpdateUserDetails extends UserDetailsEvent {
  final UserDetails updatedUserDetails;

  const UpdateUserDetails(this.updatedUserDetails);

  @override
  // TODO: implement props
  List<Object> get props => [updatedUserDetails];

  @override
  String toString() =>
      'UpdateUserDetails { updatedUserDetails | $updatedUserDetails';
}
