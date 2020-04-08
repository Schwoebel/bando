import 'package:bando/core/failures/failures.dart';
import 'package:bando/core/features/mood/data/data_sources/mood_local_data_source.dart';
import 'package:bando/core/features/mood/data/data_sources/mood_remote_data_source.dart';
import 'package:bando/core/features/mood/domain/entities/mood.dart';
import 'package:bando/core/features/mood/domain/repositories/mood_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
class MoodRepositoryImpl extends MoodRepository{
  final MoodRemoteDataSource moodRemoteDataSource;
  final MoodLocalDataSource moodLocalDataSource;
  MoodRepositoryImpl({@required this.moodLocalDataSource, @required this.moodRemoteDataSource});

  @override
  Future<Either<Failure, List<Mood>>> getRemoteMoods() async {
    try{
      List<Mood> moods = await moodRemoteDataSource.getMoods();
      await moodLocalDataSource.setMoods(moods);
      return Right(moods);
    } catch(e){
      return Left(NetworkFailure());
    }
  }

}