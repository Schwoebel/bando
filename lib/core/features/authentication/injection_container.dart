  import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:baindo/core/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:baindo/core/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:baindo/core/features/authentication/domain/repositories/auth_repository.dart';
import 'package:baindo/core/features/authentication/domain/use_cases/manage_auth.dart';
import 'package:baindo/core/features/authentication/presentation/bloc/auth/auth_bloc.dart';

final sl = GetIt.instance;

void init() {
  //! User
  // Bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      auth: sl(),
    ),
  );

  //Use Cases
  sl.registerLazySingleton(
    () => ManageAuth(
      sl(),
    ),
  );

  //Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  //Data Sources
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(firebaseAuth: sl()),
  );

  sl.registerLazySingleton<FirebaseAuth>(
    () => FirebaseAuth.instance,
  );
}
