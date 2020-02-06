import 'package:baindo/core/failures/exceptions.dart';
import 'package:baindo/features/manage_entries/data/models/entry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

const LOCAL_STORED_ENTRIES = 'LOCAL_STORED_ENTRIES';

abstract class ViewEntriesLocalDataSource {
  Future<List<EntryModel>> getEntriesFromLocalDataSource();

  Future<void> cacheEntries({@required List<EntryModel> entries});
}

class ViewEntriesLocalDataSourceImpl extends ViewEntriesLocalDataSource {
  final SharedPreferences sharedPreferences;

  ViewEntriesLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> cacheEntries({@required List<EntryModel> entries}) {
    List jsonList = List();
    entries.map((item) => jsonList.add(item.toJson())).toList();
    return sharedPreferences.setString(
        LOCAL_STORED_ENTRIES, json.encode(jsonList));
  }

  @override
  Future<List<EntryModel>> getEntriesFromLocalDataSource() {
    final jsonString =
        json.decode(sharedPreferences.getString(LOCAL_STORED_ENTRIES));
    if (jsonString != null) {
      return Future.value(
        jsonString.map((Map model) => EntryModel.fromJson(model)).toList(),
      );
    } else {
      throw CacheException();
    }
  }
}
