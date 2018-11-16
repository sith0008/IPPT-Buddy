import 'package:cloud_firestore/cloud_firestore.dart';

// Controller class which holds all function to home UI
class HomeController {
  // Function to update account's chat page with chatbot and default schedule
  static void updateAccount(String id) {
    if (id != null) {
      DocumentReference documentReference = Firestore.instance
          .collection('users')
          .document(id)
          .collection('chatUsers')
          .document('1_ChatBot');
      Map<String, String> chatData = <String, String>{
        "aboutMe": "I am a chatbot!",
        "id": "ipptbuddychatbot@ippt.com",
        "photoURL":
            "https://i.ebayimg.com/images/g/4bYAAOSwknJX0Xln/s-l300.jpg",
        "type": "personal",
        "displayName": "IPPT Buddy Bot"
      };
      documentReference.setData(chatData, merge: true).whenComplete(() {
        print("chat created");
      }).catchError((e) => print(e));

      DocumentReference pushUpRef = Firestore.instance
          .document("users/" + id + "/schedule/" + "Push Ups");
      Map<String, dynamic> pushUpData = <String, dynamic>{
        "checked": false,
        "rep": 0,
        "name": "Push Ups"
      };
      pushUpRef.setData(pushUpData, merge: true).whenComplete(() {
        print("schedule updated");
      }).catchError((e) => print(e));
      DocumentReference sitUpRef =
          Firestore.instance.document("users/" + id + "/schedule/" + "Sit Ups");
      Map<String, dynamic> sitUpData = <String, dynamic>{
        "checked": false,
        "rep": 0,
        "name": "Sit Ups"
      };
      sitUpRef.setData(sitUpData, merge: true).whenComplete(() {
        print("schedule updated");
      }).catchError((e) => print(e));
      DocumentReference runRef = Firestore.instance
          .document("users/" + id + "/schedule/" + "2.4km Run");
      Map<String, dynamic> runData = <String, dynamic>{
        "checked": false,
        "rep": 0,
        "name": "2.4km Run"
      };
      runRef.setData(runData, merge: true).whenComplete(() {
        print("schedule updated");
      }).catchError((e) => print(e));
    }
    DocumentReference dateRef = Firestore.instance.document("users/" + id);
    Map<String, dynamic> dateData = <String, dynamic>{
      "date": "Please fill up your profile!",
      "id": id
    };
    dateRef.setData(dateData, merge: true).whenComplete(() {
      print("schedule updated");
    }).catchError((e) => print(e));
  }
}
