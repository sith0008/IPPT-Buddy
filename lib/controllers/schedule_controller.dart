import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleController {
  static List<DocumentSnapshot> databaseDocuments;

  static Stream<QuerySnapshot> scheduleSnapshots(String id) {
    return Firestore.instance
        .collection('users')
        .document(id)
        .collection('schedule')
        .snapshots();
  }

  static void readData(String id) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .getDocuments();
    databaseDocuments = result.documents;
  }

  static String dateRef(String id) {
    readData(id);
    String inCase =
        "Please press the profile button on the AppBar to fill up your profile!";
    if (databaseDocuments != null) {
      return databaseDocuments[0]['date'];
    } else {
      return inCase;
    }
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
