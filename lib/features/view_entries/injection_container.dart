import 'package:baindo/core/network/network_info.dart';
import 'package:baindo/features/view_entries/data/data_sources/view_entries_local_data_source.dart';
import 'package:baindo/features/view_entries/data/data_sources/view_entries_remote_data_source.dart';
import 'package:baindo/features/view_entries/data/repositories/view_entries_repository_impl.dart';
import 'package:baindo/features/view_entries/domain/repositories/view_entries_repository.dart';
import 'package:baindo/features/view_entries/domain/use_cases/get_entries.dart';
import 'package:baindo/features/view_entries/presentation/bloc/dropdown_button/dropdown_button_bloc.dart';
import 'package:baindo/features/view_entries/presentation/bloc/view_entries/view_entries_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

void init() {
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
