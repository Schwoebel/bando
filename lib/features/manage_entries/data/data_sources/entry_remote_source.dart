import 'package:baindo/features/manage_entries/data/models/entry_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
const COLLECTION_NAME = 'entires';
abstract class EntryRemoteSource {
  Future<void> createEntry({@required EntryModel task});

  Future<EntryModel> readEntry({@required String id});

  Future<void> updateEntry({@required EntryModel entry, String id});

  Future<void> deleteEntry({@required String id});

}

class EntryRemoteSourceImpl extends EntryRemoteSource {
  final Firestore firestore;

  EntryRemoteSourceImpl({@required this.firestore});

  @override
  Future<void> createEntry({@required EntryModel task}) {
    return this.firestore.collection(COLLECTION_NAME).document().setData(task.toJson());
  }

  @override
  Future<void> deleteEntry({@required String id}) {
    return this.firestore.collection(COLLECTION_NAME).document(id).delete();
  }

  @override
  Future<EntryModel> readEntry({@required String id}) async {
    DocumentSnapshot snapshot = await this.firestore.collection(COLLECTION_NAME).document(id).get();
    return EntryModel.fromJson(snapshot.documentID, snapshot.data);
  }

  @override
  Future<void> updateEntry({@required EntryModel entry, @required String id}) async {
    return await this.firestore.collection(COLLECTION_NAME).document(id).setData(entry.toJson(), merge: true);
  }



}
