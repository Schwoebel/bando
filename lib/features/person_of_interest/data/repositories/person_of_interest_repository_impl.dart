import 'package:bando/core/failures/failures.dart';
import 'package:bando/features/person_of_interest/data/models/person_of_interest_model.dart';
import 'package:bando/features/person_of_interest/domain/entities/person_of_interest_entity.dart';
import 'package:bando/core/network/network_info.dart';
import 'package:bando/features/person_of_interest/data/data_sources/person_of_interest_local_data_source.dart';
import 'package:bando/features/person_of_interest/data/data_sources/person_of_interest_remote_data_source.dart';
import 'package:bando/features/person_of_interest/domain/repositories/person_of_interest_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

class PersonOfInterestRepositoryImpl extends PersonOfInterestRepository {
  final PersonOfInterestLocalDataSource localDataSource;
  final PersonOfInterestRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PersonOfInterestRepositoryImpl({
    @required this.networkInfo,
    @required this.localDataSource,
    @required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, bool>> delete({String personOfInterestId}) async {
    if (await networkInfo.isConnected) {
      try {
        final success = await remoteDataSource.delete(id: personOfInterestId);
        return Right(success);
      } on PlatformException {
        return Left(PlatformFailure());
      } catch (e) {
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, PersonOfInterest>> read({String id}) async {
    if (await networkInfo.isConnected) {
      try {
        final personOfInterest = await remoteDataSource.read(id: id);
        return Right(personOfInterest);
      } on PlatformException {
        return Left(PlatformFailure());
      } catch (e) {
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, List<PersonOfInterest>>> readList() async {
    if (await networkInfo.isConnected) {
      try {
        final List<PersonOfInterest> personOfInterest = await remoteDataSource.readAllAllowed();
        return Right(personOfInterest);
      } on PlatformException {
        return Left(PlatformFailure());
      } catch (e) {
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, PersonOfInterest>> update(
      {String id, PersonOfInterest person}) async {
    if (await networkInfo.isConnected) {
      try {
        final personOfInterest =
            await remoteDataSource.update(id: id, person: person);
        return Right(personOfInterest);
      } on PlatformException {
        return Left(PlatformFailure());
      } catch (e) {
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, PersonOfInterest>> create({@required PersonOfInterest personOfInterest}) async {
    if (await networkInfo.isConnected) {
      try {
        final newPersonOfInterest = await remoteDataSource.create(person: personOfInterest);
        return Right(newPersonOfInterest);
      } on PlatformException {
        return Left(PlatformFailure());
      } catch (e) {
        return Left(CacheFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
