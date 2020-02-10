import 'package:baindo/features/manage_entries/data/models/mood.model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

abstract class MoodRemoteDataSource{
  Future<List<MoodModel>> getMoods();
}

class MoodRemoteDataSourceImpl extends MoodRemoteDataSource{
  final Firestore firestore;

  MoodRemoteDataSourceImpl({@required this.firestore});
  @override
  Future<List<MoodModel>> getMoods() async {
    QuerySnapshot snapshot = await firestore.collection('moods').getDocuments();
    return snapshot.documents.map((DocumentSnapshot document) => MoodModel.fromJson(document.data)).toList();
  }

}