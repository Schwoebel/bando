import 'package:bando/features/mood/data/data_sources/mood_remote_data_source.dart';
import 'package:bando/features/mood/data/repositories/mood_repository_impl.dart';
import 'package:bando/features/mood/domain/repositories/mood_repository.dart';
import 'package:bando/features/mood/domain/use_cases/get_moods.dart';
import 'package:get_it/get_it.dart';

import 'data/data_sources/mood_local_data_source.dart';
import 'presentation/bloc/mood/mood_bloc.dart';

GetIt sl = GetIt.instance;

init() async {
  //Bloc
  sl.registerFactory(
    () => MoodBloc(
      moods: sl(),
    ),
  );

  //UseCases
  sl.registerLazySingleton<GetMoods>(
    () => GetMoods(
      moodRepository: sl(),
    ),
  );

  sl.registerLazySingleton<MoodRepository>(
    () => MoodRepositoryImpl(
      moodLocalDataSource: sl(),
      moodRemoteDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<MoodRemoteDataSource>(
    () => MoodRemoteDataSourceImpl(
      firestore: sl(),
    ),
  );
    sl.registerLazySingleton<MoodLocalDataSource>(
      () => MoodLocalDataSourceImpl(
        sharedPreferences: sl(),
      ),
    );
}
