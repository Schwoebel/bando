import 'package:baindo/core/features/user_details/domain/repositories/user_details_repository.dart';
import 'package:baindo/core/features/user_details/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:get_it/get_it.dart';

import 'domain/use_cases/manage_user_details.dart';
import 'presentation/bloc/author/author_bloc.dart';

final sl = GetIt.instance;

void init() async {
  //Bloc
  sl.registerFactory<UserDetailsBloc>(
    () => UserDetailsBloc(
      manageUserDetails: sl<ManageUserDetails>(),
    ),
  );
  sl.registerFactory<AuthorBloc>(
    () => AuthorBloc(
      sl<ManageUserDetails>(),
    ),
  );

  sl.registerLazySingleton<ManageUserDetails>(
    () => ManageUserDetails(
      repository: sl<UserDetailsRepository>(),
    ),
  );
}
