import 'package:baindo/core/data_sources/user_details_local_data_source.dart';
import 'package:baindo/core/data_sources/user_details_remote_data_source.dart';
import 'package:baindo/core/repositories/user_details_repository_impl.dart';
import 'package:baindo/core/features/user_details/domain/repositories/user_details_repository.dart';
import 'package:baindo/core/features/user_details/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:baindo/core/network/network_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

import 'domain/use_cases/manage_user_details.dart';

final sl = GetIt.instance;

void init() async {
  //Bloc
  sl.registerFactory<UserDetailsBloc>(
    () => UserDetailsBloc(
      manageUserDetails: sl<ManageUserDetails>(),
    ),
  );

  sl.registerLazySingleton<ManageUserDetails>(
    () => ManageUserDetails(
      repository: sl<UserDetailsRepository>(),
    ),
  );




}
