import 'package:baindo/features/entries/data/data_sources/entry_remote_source.dart';
import 'package:baindo/features/entries/data/repositories/manage_entries_repository_impl.dart';
import 'package:baindo/features/entries/domain/repositories/manage_entries_repository.dart';
import 'package:baindo/features/entries/domain/use_cases/manage_entry.dart';
import 'package:baindo/features/entries/presentation/bloc/add_entry/add_entry_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/data_sources/view_entries_local_data_source.dart';
import 'data/data_sources/view_entries_remote_data_source.dart';
import 'data/repositories/view_entries_repository_impl.dart';
import 'domain/repositories/view_entries_repository.dart';
import 'domain/use_cases/get_entries.dart';
import 'presentation/bloc/dropdown_button/dropdown_button_bloc.dart';
import 'presentation/bloc/view_entries/view_entries_bloc.dart';

GetIt sl = GetIt.instance;

init() async {
  //Bloc

  sl.registerFactory(() => AddEntryBloc(manageEntryOnRemoteSource: sl()));

  //UseCases
  sl.registerLazySingleton<ManageEntryOnRemoteSource>(
    () => ManageEntryOnRemoteSource(
      repository: sl(),
    ),
  );

  sl.registerLazySingleton<ManageEntriesRepository>(
    () => ManageEntriesRepositoryImpl(
      entryRemoteSource: sl(),
      userDetailsLocalDataSource: sl(),
    ),
  );

  sl.registerLazySingleton<EntryRemoteSource>(
    () => EntryRemoteSourceImpl(
      firestore: sl(),
    ),
  );
  sl.registerFactory<ViewEntriesBloc>(
      () => ViewEntriesBloc(
      getEntries: sl(),
    ),
  );

  sl.registerFactory<DropdownButtonBloc>(
      () => DropdownButtonBloc(),
  );

  sl.registerLazySingleton<GetEntries>(
      () => GetEntries(
      viewEntriesRepository: sl(),
    ),
  );

  sl.registerLazySingleton<ViewEntriesRepository>(
      () => ViewEntriesRepositoryImpl(
      viewEntriesLocalDataSource: sl(),
      viewEntriesRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<ViewEntriesRemoteDataSource>(
      () => ViewEntriesRemoteDataSourceImpl(
      firestore: sl(),
    ),
  );

  sl.registerLazySingleton<ViewEntriesLocalDataSource>(
      () => ViewEntriesLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
}
