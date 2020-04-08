import 'package:bando/features/entries/data/models/entry_model.dart';
import 'package:bando/features/entries/data/data_sources/view_entries_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

const COLLECTION_NAME = 'entries';

abstract class EntryRemoteSource {
  Future<void> createEntry(
    {@required EntryModel entry, @required String personOfInterestId});

  Future<EntryModel> readEntry(
    {@required String id, @required String personOfInterestId});

  Future<void> updateEntry(
    {@required EntryModel entry, String id, @required String personOfInterestId});

  Future<void> deleteEntry(
    {@required String id, @required String personOfInterestId});
}

class EntryRemoteSourceImpl extends EntryRemoteSource {
  final Firestore firestore;

  EntryRemoteSourceImpl({@required this.firestore});

  @override
  Future<bool> createEntry(
    {@required EntryModel entry, @required String personOfInterestId}) async {
    Map<dynamic, dynamic> entryMap = entry.toJson();
    try {
      await this
        .firestore
        .collection(PERSON_OF_INTEREST)
        .document(personOfInterestId)
        .collection(ENTRIES_COLLECTION_NAME)
        .document()
        .setData(entryMap);
      return Future.value(true);
    } catch (e) {
      return Future.value(false);
    }
}

@override
Future<void> deleteEntry(
  {@required String id, @required String personOfInterestId}) async {
  return this.firestore.collection(COLLECTION_NAME).document(id).delete();
}

@override
Future<EntryModel> readEntry(
  {@required String id, @required String personOfInterestId}) async {
  DocumentSnapshot snapshot =
  await this.firestore.collection(COLLECTION_NAME).document(id).get();
  return EntryModel.fromJson(snapshot.documentID, snapshot.data);
}

@override
Future<void> updateEntry(
  {@required EntryModel entry, @required String id, @required String personOfInterestId}) async {
  return await this
    .firestore
    .collection(COLLECTION_NAME)
    .document(id)
    .setData(entry.toJson(), merge: true);
}}
