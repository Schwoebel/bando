import 'dart:convert';

import 'package:bando/core/features/user_details/data/models/user_details.model.dart';
import 'package:bando/core/features/user_details/domain/entities/user_details.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

const USER_DETAILS_STORAGE_KEY = 'User_Details';

abstract class UserDetailsLocalDataSource {
  Future<bool> saveUserDetails(UserDetailsModel userDetails);

  Future<UserDetailsModel> getUserDetails();
}

class UserDetailsLocalDataSourceImpl extends UserDetailsLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserDetailsLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<bool> saveUserDetails(UserDetailsModel userDetails) async {
    return await this.sharedPreferences.setString(
          USER_DETAILS_STORAGE_KEY,
          jsonEncode(
            userDetails.toJson(),
          ),
        );
  }

  @override
  Future<UserDetailsModel> getUserDetails() {
    if(sharedPreferences.containsKey(USER_DETAILS_STORAGE_KEY)){
      String userDetailsString = sharedPreferences.getString(USER_DETAILS_STORAGE_KEY);

      UserDetailsModel userDetails = UserDetailsModel.fromJson(
        jsonDecode(
          userDetailsString,
        ),
      );
      return Future.value(userDetails ?? null);
    } else {
      return Future.value(null);
    }

  }
}
