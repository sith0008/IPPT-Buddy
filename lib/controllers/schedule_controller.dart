import 'package:cloud_firestore/cloud_firestore.dart';

// Controller class which holds all the functions to schedule UI
class ScheduleController {
  // Variables used
  static List<DocumentSnapshot> databaseDocuments;

  // Generate users schedules from database
  static Stream<QuerySnapshot> scheduleSnapshots(String id) {
    return Firestore.instance
        .collection('users')
        .document(id)
        .collection('schedule')
        .snapshots();
  }

  // Read data from database to get document of user with id = id
  static void readData(String id) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .getDocuments();
    databaseDocuments = result.documents;
  }

  // Update database with date data
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

  /// Update database for user's schedule with checked box value
  /// checked box value can either be true or false
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
