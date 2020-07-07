import 'dart:async';
import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/user_details/domain/entities/user_details.dart';
import 'package:bando/features/user_details/domain/use_cases/manage_user_details.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'author_event.dart';
part 'author_state.dart';

class AuthorBloc extends Bloc<AuthorEvent, AuthorState> {
  final ManageUserDetails manageUserDetails;

  AuthorBloc(this.manageUserDetails) : super(InitialAuthorState());

  @override
  Stream<AuthorState> mapEventToState(AuthorEvent event) async* {
    if (event is GetAuthors) {
      yield LoadingAuthors();
      Either<Failure, UserDetails> result = await manageUserDetails(null);
      yield* _eitherAuthorsOrFailure(result);
    } else if (event is AuthorSelected) {
      yield LoadingAuthors();
      yield HasAuthors(event.authors);
    }
  }

  Stream<AuthorState> _eitherAuthorsOrFailure(
      Either<Failure, UserDetails> results) async* {
    yield results.fold(
      (failure) => HasErrorAuthorState(),
      (success) => HasAuthors(success.authors.cast<String>().toList()),
    );
  }
}
