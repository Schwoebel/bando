import 'package:baindo/core/network/network_info.dart';
import 'package:baindo/features/manage_entries/data/data_sources/entry_remote_source.dart';
import 'package:baindo/features/manage_entries/data/data_sources/mood_remote_data_source.dart';
import 'package:baindo/features/manage_entries/data/repositories/manage_entries_repository_impl.dart';
import 'package:baindo/features/manage_entries/data/repositories/mood_repository_impl.dart';
import 'package:baindo/features/manage_entries/domain/repositories/manage_entries_repository.dart';
import 'package:baindo/features/manage_entries/domain/repositories/mood_repository.dart';
import 'package:baindo/features/manage_entries/domain/use_cases/manage_entry.dart';
import 'package:baindo/features/manage_entries/domain/use_cases/get_moods.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/create_entry/create_entry_bloc.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/mood/mood_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.instance;

init() async {
  //Bloc
  sl.registerFactory(
    () => MoodBloc(
      moods: sl(),
    ),
  );
  sl.registerFactory(
    () => CreateEntryBloc(
      manageEntryOnRemoteSource: sl(),
    ),
  );

  //UseCases
  sl.registerLazySingleton<GetMoods>(
    () => GetMoods(
      moodRepository: sl(),
    ),
  );
  sl.registerLazySingleton<ManageEntryOnRemoteSource>(
    () => ManageEntryOnRemoteSource(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<MoodRepository>(
    () => MoodRepositoryImpl(
      moodRemoteDataSource: sl(),
    ),
  );
  sl.registerLazySingleton<ManageEntriesRepository>(
    () => ManageEntriesRepositoryImpl(
      entryRemoteSource: sl(),
    ),
  );

  sl.registerLazySingleton<EntryRemoteSource>(
    () => EntryRemoteSourceImpl(
      firestore: sl(),
    ),
  );
  sl.registerLazySingleton<MoodRemoteDataSource>(
    () => MoodRemoteDataSourceImpl(
      firestore: sl(),
    ),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );
  final fireStore = Firestore.instance;
  sl.registerLazySingleton<Firestore>(() => fireStore);

  sl.registerLazySingleton<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );
}
