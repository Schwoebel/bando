import 'package:baindo/features/manage_entries/data/data_sources/entry_remote_source.dart';
import 'package:baindo/features/manage_entries/data/repositories/manage_entries_repository_impl.dart';
import 'package:baindo/features/manage_entries/domain/repositories/manage_entries_repository.dart';
import 'package:baindo/features/manage_entries/domain/use_cases/manage_entry.dart';
import 'package:baindo/features/manage_entries/presentation/bloc/add_entry/add_entry_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
