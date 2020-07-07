part of 'author_bloc.dart';

@immutable
abstract class AuthorState extends Equatable{}

class InitialAuthorState extends AuthorState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class LoadingAuthors extends AuthorState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class HasAuthors extends AuthorState {
  final List<dynamic> authors;

  HasAuthors(this.authors);

  @override
  // TODO: implement props
  List<Object> get props => [authors];
}

class HasErrorAuthorState extends AuthorState{
  @override
  // TODO: implement props
  List<Object> get props => null;

}

