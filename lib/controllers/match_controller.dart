import 'package:cloud_firestore/cloud_firestore.dart';

/// Controller class which holds all the functions to matchme UI and match_users UI
class MatchController {
  // Variables required
  static List<DocumentSnapshot> databaseDocuments;
  static List<DocumentSnapshot> usersDocuments;

  /// Returns true if parameters passed are not null, return false otherwise
  /// To check if all input are filled up
  static bool fieldFilled(String location, String date) {
    if (location != null && date != null) {
      return true;
    } else {
      return false;
    }
  }

  /// Read data from database to get document of user with id = id
  static void readData(String id) async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .getDocuments();
    databaseDocuments = result.documents;
  }

  /// Read data from database to get document of users
  static void readUsers() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('users').getDocuments();
    usersDocuments = result.documents;
  }

  /// Generate match users with the same location and date
  static Stream<QuerySnapshot> userSnapshots(
      String id, String location, String date) {
    return Firestore.instance
        .collection('users')
        .where('location', isEqualTo: location)
        .where('matchDate', isEqualTo: date)
        .snapshots();
  }

  /// Add users to chatlist of both users - User that match and matched user
  static void addUserToChat(
      String id, String chatId, DocumentSnapshot snapshot) {
    readData(id);
    readUsers();
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
      "type": "personal"
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
      "type": "personal"
    };
    documentReference2.setData(profilesData2, merge: true).whenComplete(() {
      print("other chat created");
    }).catchError((e) => print("Errorrrrrrrrrrrr" + e));
  }

  /// Add group chat into chatlist
  static void addGroupChat(String id, String location) {
    DocumentReference documentReference = Firestore.instance
        .collection('users')
        .document(id)
        .collection('chatUsers')
        .document(location);
    Map<String, String> groupData = <String, String>{
      "displayName": location,
      "id": location,
      "photoURL":
          'https://d30zbujsp7ao6j.cloudfront.net/wp-content/uploads/2017/07/unnamed.png',
      "aboutMe": "Start exercising with a group here!",
      "type": "group"
    };
    documentReference.setData(groupData, merge: true).whenComplete(() {
      print("group chat created");
    }).catchError((e) => print(e));
  }

  /// update profile with location and date
  static void updateProfile(String id, String location, String date) {
    DocumentReference documentReference =
        Firestore.instance.collection('users').document(id);
    Map<String, String> groupData2 = <String, String>{
      "location": location,
      "matchDate": date
    };
    documentReference.setData(groupData2, merge: true).whenComplete(() {
      print("profile updated");
    }).catchError((e) => print(e));
  }
}
