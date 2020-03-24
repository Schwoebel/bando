import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;

  Failure([this.properties = const <dynamic>[]]) : super();

  @override
  // TODO: implement props
  List<Object> get props => [properties];
}

//Error Messages
const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Error';
const String INVALID_INPUT_FAILURE_MESSAGE =
  "Invalid Input - The number must be a positive number with no decimal places or 0";
const String PLATFORM_FAILURE_MESSAGE = "There was an issue with Firebase";
const String NETWORK_FAILURE_MESSAGE = "There was in issue with the connection to the internet";
const String UNKNOWN_ERROR = "There was an unknown error";

//General Failures

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class PlatformFailure extends Failure {}

class WrongPasswordFailure extends Failure {}

class UserNotFoundFailure extends Failure {}

mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    case PlatformFailure:
      return PLATFORM_FAILURE_MESSAGE;
    case NetworkFailure:
      return NETWORK_FAILURE_MESSAGE;
    default:
      return UNKNOWN_ERROR;
  }
}