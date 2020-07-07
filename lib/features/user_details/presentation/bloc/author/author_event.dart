part of 'author_bloc.dart';

@immutable
abstract class AuthorEvent extends Equatable {}

class GetAuthors extends AuthorEvent{

  GetAuthors();

  @override
  // TODO: implement props
  List<Object> get props => [null];

}

class AuthorSelected extends AuthorEvent {
  final List<String> authors;

  AuthorSelected(this.authors);

  @override
  // TODO: implement props
  List<Object> get props => [authors];


}