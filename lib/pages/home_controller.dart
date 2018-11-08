import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController {

  void updateAccount(String id) {
    if(id != null){
    DocumentReference documentReference = Firestore.instance
        .collection('users')
        .document(id)
        .collection('chatUsers')
        .document('ipptbuddychatbot@ippt.com');
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
    }
  }
}
