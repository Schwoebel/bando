import 'dart:convert';

import 'package:bando/features/mood/data/models/mood.model.dart';
import 'package:bando/features/mood/domain/entities/mood.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

const MOODS_STORAGE_KEY = 'Moods';
abstract class MoodLocalDataSource{
  Future<bool> setMoods(List<MoodModel> moods);
  Future<List<MoodModel>> getMoods();
}

class MoodLocalDataSourceImpl extends MoodLocalDataSource{
  final SharedPreferences sharedPreferences;

  MoodLocalDataSourceImpl({@required this.sharedPreferences});

  Future<List<MoodModel>> getMoods() async {
    String moodListString =
    sharedPreferences.getString(MOODS_STORAGE_KEY);
    List<MoodModel> list = (json.decode(moodListString) as List)
      .map((e) => MoodModel.fromLocalStorageJson(e))
      .toList();
    return list;
  }

  @override
  Future<bool> setMoods(List<MoodModel> moods) async {
    return await _convertAndSave(moods);
  }

  Future<bool> _convertAndSave(List<MoodModel> moodList) async {
    String jsonString = _convertMoodListToJSon(moodList);
    return _saveMoodListString(jsonString);
  }

  String _convertMoodListToJSon(
    List<MoodModel> moodList) {
    List jsonList = List();
    moodList.map((item) => jsonList.add(item.toJson())).toList();
    return json.encode(jsonList);
  }

  Future<bool> _saveMoodListString(
    String moodListString) async {
    return sharedPreferences.setString(
      MOODS_STORAGE_KEY, moodListString);
  }

}