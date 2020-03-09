import 'package:baindo/core/features/user_profile/presentation/bloc/user_details/user_details_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

void init() async{
  //Bloc
  sl.registerFactory<UserDetailsBloc>(()=> UserDetailsBloc(

  ));
}