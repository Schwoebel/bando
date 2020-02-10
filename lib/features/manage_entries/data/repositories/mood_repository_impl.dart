import 'package:baindo/core/failures/failures.dart';
import 'package:baindo/features/manage_entries/data/data_sources/mood_remote_data_source.dart';
import 'package:baindo/features/manage_entries/domain/entities/mood.dart';
import 'package:baindo/features/manage_entries/domain/repositories/mood_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
class MoodRepositoryImpl extends MoodRepository{
  final MoodRemoteDataSource moodRemoteDataSource;

  MoodRepositoryImpl({@required this.moodRemoteDataSource});

  @override
  Future<Either<Failure, List<Mood>>> getRemoteMoods() async {
    try{
      List<Mood> moods = await moodRemoteDataSource.getMoods();
      return Right(moods);
    } catch(e){
      return Left(NetworkFailure());
    }
  }

}