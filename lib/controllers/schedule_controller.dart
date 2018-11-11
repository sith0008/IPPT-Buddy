import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleController {

  static Stream<QuerySnapshot> scheduleSnapshots(String id) {
    return Firestore.instance
        .collection('users')
        .document(id)
        .collection('schedule')
        .snapshots();
  }

  static void scheduleRef(bool value, String document, String id) {
    DocumentReference itemRef =
        Firestore.instance.document("users/" + id + "/schedule/" + document);
    Map<String, bool> checkedData = <String, bool>{
      "checked": value,
    };
    itemRef
        .setData(checkedData, merge: true)
        .whenComplete(() {})
        .catchError((e) => print(e));
  }
}
