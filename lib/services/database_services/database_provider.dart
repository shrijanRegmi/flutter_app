import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:do_you_flutter/models/item_model.dart';

class DatabaseProvider {
  final _ref = Firestore.instance;

  //send data to firebase
  Future sendDataToFirebase(
      final _title, final _description, final _imgPath, final _date) async {
    try {
      await _ref.collection("ItemList").add({
        "title": _title,
        "description": _description,
        "imgPath": _imgPath,
        "date": _date
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  //delete data
  Future deleteItem(final _docId) async {
    return await _ref.collection("ItemList").document(_docId).delete();
  }

  //get data from firebase
  List<Item> _getItemFromFirebase(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Item(
        doc.documentID,
        doc["title"],
        doc["description"],
        doc["imgPath"],
        doc["date"],
      );
    }).toList();
  }

  //stream of data
  Stream<List<Item>> get listOfItems => _ref
      .collection("ItemList")
      .orderBy("date", descending: true)
      .snapshots()
      .map(_getItemFromFirebase);
}
