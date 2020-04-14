import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/features/authentication/domain/entities/auth.dart';
import 'package:bando/core/features/authentication/domain/use_cases/manage_auth.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final ManageAuth auth;

  AuthBloc({
    @required this.auth,
  });

  @override
  AuthState get initialState => Empty();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is GetCurrentUserEvent) {
      yield Loading();
      final failureOrAuth = await auth.getCurrentUser();
      yield* _eitherLoadedOrErrorState(failureOrAuth);
    } else if (event is CreateUserEvent) {
      yield Loading();
      final failureOrAuth = await auth.createUser(
        event.email,
        event.password,
      );
      yield* _eitherLoadedOrErrorState(failureOrAuth);
    } else if (event is SignInEvent) {
      yield SigningIn();
      final failureOrAuth = await auth.signIn(
        event.email,
        event.password,
      );
      yield* _eitherLoadedOrErrorState(failureOrAuth);
    }
    if (event is SignOutEvent) {
      yield Loading();
      final failureOrAuth = await auth.signOut();
      yield* _eitherEmptyOrErrorState(failureOrAuth);
    }
  }

  Stream<AuthState> _eitherLoadedOrErrorState(
    Either<Failure, Auth> failureOrAuth,
  ) async* {
    yield failureOrAuth.fold(
      (Failure failure) => failure is NotLoggedInFailure
          ? Loaded(auth: Auth(currentUser: null))
          : Error(_mapFailureToMessage(failure)),
      (Auth auth) => Loaded(auth: auth),
    );
  }

  Stream<AuthState> _eitherEmptyOrErrorState(
    Either<Failure, Auth> failureOrAuth,
  ) async* {
    yield failureOrAuth.fold(
      (failure) => Error(_mapFailureToMessage(failure)),
      (auth) => Empty(),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      case UserNotFoundFailure:
        return USER_NOT_FOUND_MESSAGE;
      case WrongPasswordFailure:
        return WRONG_PASSWORD_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }
}
