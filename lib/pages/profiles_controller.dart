import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilesController {
  
  bool fieldFilled(String _nickName, String _min, String _sec, String _award,
      String _pushUp, String _sitUp, String _dateValue) {
    if (_nickName != null &&
        _min != null &&
        _sec != null &&
        _award != null &&
        _pushUp != null &&
        _sitUp != null &&
        _dateValue != null) {
      return true;
    } else {
      return false;
    }
  }

  String findTiming(String _min, String _sec) {
    int min = int.parse(_min) * 60;
    int sec = int.parse(_sec);
    int time = min + sec;
    return time.toString();
  }

  void updateProfile(String nickName, String time, String pushUp, String sitUp,
      String award, String date, String id) {
    DocumentReference profileReference =
        Firestore.instance.collection('users').document(id);
    Map<String, dynamic> profilesData = <String, dynamic>{
      "name": nickName,
      "run": time,
      "pushup": pushUp,
      "situp": sitUp,
      "award": award,
      "date": date
    };
    profileReference.setData(profilesData, merge: true).whenComplete(() {
      print("profile created");
    }).catchError((e) => print(e));
  }

  void updateSchedule(String pushUp, String sitUp, String _min, String _sec, String id) {
    int pUrep = int.parse(pushUp) + 5;
    int sUrep = int.parse(sitUp) + 5;
    int sec;
    int min;
    if (int.parse(_sec) > 10) {
      sec = int.parse(_sec) - 10;
    } else {
      min = int.parse(_min) - 1;
      sec = int.parse(_sec) + 50;
    }
    DocumentReference pushUpRef =
        Firestore.instance.document("users/" + id + "/schedule/" + "Push Ups");
    Map<String, dynamic> pushUpData = <String, dynamic>{
      "checked": false,
      "rep": pUrep,
      "name": "Push Ups"
    };
    pushUpRef.setData(pushUpData, merge: true).whenComplete(() {
      print("schedule updated");
    }).catchError((e) => print(e));
    DocumentReference sitUpRef =
        Firestore.instance.document("users/" + id + "/schedule/" + "Sit Ups");
    Map<String, dynamic> sitUpData = <String, dynamic>{
      "checked": false,
      "rep": sUrep,
      "name": "Sit Ups"
    };
    sitUpRef.setData(sitUpData, merge: true).whenComplete(() {
      print("schedule updated");
    }).catchError((e) => print(e));
    String time = min.toString() + " Mins " + sec.toString() + " Sec";
    DocumentReference runRef =
        Firestore.instance.document("users/" + id + "/schedule/" + "2.4km Run");
    Map<String, dynamic> runData = <String, dynamic>{
      "checked": false,
      "rep": time,
      "name": "2.4km Run"
    };
    runRef.setData(runData, merge: true).whenComplete(() {
      print("schedule updated");
    }).catchError((e) => print(e));
  }
}