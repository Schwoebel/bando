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


//General Failures

class ServerFailure extends Failure {}

class CacheFailure extends Failure {}

class NetworkFailure extends Failure {}

class PlatformFailure extends Failure {}