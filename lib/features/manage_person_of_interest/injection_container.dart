import 'package:bando/core/features/authentication/injection_container.dart';
import 'package:bando/features/manage_person_of_interest/data/data_sources/person_of_interest_local_data_source.dart';
import 'package:bando/features/manage_person_of_interest/data/data_sources/person_of_interest_remote_data_source.dart';
import 'package:bando/features/manage_person_of_interest/data/repositories/person_of_interest_repository_impl.dart';
import 'package:bando/features/manage_person_of_interest/domain/repositories/person_of_interest_repository.dart';
import 'package:bando/features/manage_person_of_interest/domain/use_cases/manage_person_of_interest.dart';
import 'package:bando/features/manage_person_of_interest/presentation/bloc/person_of_interest/person_of_interest_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

void init() async {
  //Bloc
  sl.registerFactory<PersonOfInterestBloc>(
    () => PersonOfInterestBloc(
      managePersonOfInterest: sl(),
    ),
  );
  sl.registerLazySingleton<ManagePersonOfInterest>(
    () => ManagePersonOfInterest(
      personOfInterestRepository: sl(),
    ),
  );
  //Repository
  sl.registerLazySingleton<PersonOfInterestRepository>(
    () => PersonOfInterestRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  //DataSources
  sl.registerLazySingleton<PersonOfInterestLocalDataSource>(
    () => PersonOfInterestLocalDataSourceImpl(),
  );
  sl.registerLazySingleton<PersonOfInterestRemoteDataSource>(
    () => PersonOfInterestRemoteDataSourceImpl(
      firestore: sl(),
      firebaseAuth: sl(),
      userDetailsRemoteDataSource: sl(),
      userDetailsLocalDataSource: sl()
    ),
  );
}
