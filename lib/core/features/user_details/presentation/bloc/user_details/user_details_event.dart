part of 'user_details_bloc.dart';

@immutable
abstract class UserDetailsEvent extends Equatable{}

class GetUserDetailsEvent extends UserDetailsEvent {
  @override
  // TODO: implement prop
  List<Object> get props => null;
}

class UpdateAuthorList extends UserDetailsEvent{
  final String newAuthor;

  UpdateAuthorList(this.newAuthor);

  @override
  // TODO: implement props
  List<Object> get props => [newAuthor];

}


