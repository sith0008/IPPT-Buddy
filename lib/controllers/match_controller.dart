import 'package:cloud_firestore/cloud_firestore.dart';

class MatchController {
  static List<DocumentSnapshot> databaseDocuments;
  static List<DocumentSnapshot> usersDocuments;
  static void readData(String id) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .getDocuments();
    databaseDocuments = result.documents;
  }

  static void readUsers() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('users').getDocuments();
    usersDocuments = result.documents;
  }

  static List<DocumentSnapshot> userDocuments;
  static void readUser() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('users').getDocuments();
    userDocuments = result.documents;
  }

  static Stream<QuerySnapshot> userSnapshots(String id, String location) {
    return Firestore.instance
        .collection('users')
        .where('location', isEqualTo: location)
        .snapshots();
  }

  static void addUserToChat(String id, String chatId, DocumentSnapshot snapshot) {
    readData(id);
    readUser();
    readUser();
    DocumentReference documentReference = Firestore.instance
        .collection('users')
        .document(id)
        .collection('chatUsers')
        .document(chatId);
    Map<String, String> profilesData = <String, String>{
      "displayName": snapshot['name'],
      "id": snapshot['id'],
      "photoURL": snapshot['imageURL'],
      "aboutMe": "I am your IPPT buddy!",
    };
    documentReference.setData(profilesData, merge: true).whenComplete(() {
      print("chat created");
    }).catchError((e) => print(e));
    print(databaseDocuments[0]['id']);
    DocumentReference documentReference2 = Firestore.instance
        .collection('users')
        .document(chatId)
        .collection('chatUsers')
        .document(id);
    Map<String, String> profilesData2 = <String, String>{
      "displayName": databaseDocuments[0]['name'],
      "id": databaseDocuments[0]['id'],
      "photoURL": databaseDocuments[0]['imageURL'],
      "aboutMe": "I am your IPPT buddy!",
    };
    documentReference2.setData(profilesData2, merge: true).whenComplete(() {
      print("other chat created");
    }).catchError((e) => print("Errorrrrrrrrrrrr" + e));
  }
}
