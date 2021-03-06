import 'package:bando/core/network/network_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/user_details/data/data_sources/user_details_local_data_source.dart';
import 'features/user_details/data/data_sources/user_details_remote_data_source.dart';
import 'features/user_details/domain/repositories/user_details_repository.dart';
import 'features/user_details/data/repositories/user_details_repository_impl.dart';
import 'features/entries/injection_container.dart' as me_di;
import 'features/person_of_interest/injection_container.dart' as pi_di;
import 'features/mood/injection_container.dart' as mood_di;
import 'features/authentication/injection_container.dart' as auth_di;
import 'features/user_details/injection_container.dart' as userDetails_di;

final sl = GetIt.instance;

init() async {
  //Firebase
  sl.registerLazySingleton<Firestore>(() => Firestore.instance);
  //networkInfo
  sl.registerLazySingleton<DataConnectionChecker>(
      () => DataConnectionChecker());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      sl(),
    ),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );
  sl.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
  sl.registerLazySingleton<UserDetailsRemoteDataSource>(
      () => UserDetailsRemoteDataSourceImpl(
      fireStore: sl(),
      firebaseAuth: FirebaseAuth.instance,
    ),
  );
  sl.registerLazySingleton<UserDetailsRepository>(
      () => UserDetailsRepositoryImpl(
      userDetailsLocalDataSource: sl(),
      userDetailsRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  sl.registerLazySingleton<UserDetailsLocalDataSource>(
      () => UserDetailsLocalDataSourceImpl(
      sharedPreferences: sharedPreferences,
    ),
  );

  me_di.init();
  auth_di.init();
  mood_di.init();
  pi_di.init();
  userDetails_di.init();
}
