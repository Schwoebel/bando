import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

abstract class UserDetailsLocalDataSource{}

class UserDetailsLocalDataSourceImpl extends UserDetailsLocalDataSource{
  final SharedPreferences sharedPreferences;

  UserDetailsLocalDataSourceImpl({@required this.sharedPreferences});


  
}