import 'package:cloud_firestore/cloud_firestore.dart';

// Controller class which holds all the functions to profiles UI
class ProfilesController {
  /// Returns true if parameters passed are not null, return false otherwise
  /// To check if all input are filled up
  static bool fieldFilled(String _nickName, String _min, String _sec,
      String _award, String _pushUp, String _sitUp, String _dateValue) {
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

  // Function to find timing in min and second
  static String findTiming(String _min, String _sec) {
    int min = int.parse(_min) * 60;
    int sec = int.parse(_sec);
    int time = min + sec;
    return time.toString();
  }

  // update database with profile and settings details
  static void updateProfile(
      String nickName,
      String time,
      String pushUp,
      String sitUp,
      String award,
      String date,
      String id,
      String _min,
      String _sec) {
    String matchTime = _min.toString() + " Mins " + _sec.toString() + " Sec";
    DocumentReference profileReference =
        Firestore.instance.collection('users').document(id);
    Map<String, dynamic> profilesData = <String, dynamic>{
      "name": nickName,
      "run": time,
      "pushup": pushUp,
      "situp": sitUp,
      "award": award,
      "date": date,
      "id": id,
      "imageURL":
          'http://www.desiformal.com/assets/images/default-userAvatar.png',
      "matchRun": matchTime
    };
    profileReference.setData(profilesData, merge: true).whenComplete(() {
      print("profile created");
    }).catchError((e) => print(e));
  }

  // update database with schedule based on profile settings
  static void updateSchedule(
      String pushUp, String sitUp, String _min, String _sec, String id) {
    int pUrep = int.parse(pushUp) + 5;
    int sUrep = int.parse(sitUp) + 5;
    int sec;
    int min;
    if (int.parse(_sec) >= 10) {
      min = int.parse(_min);
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

  /// test if the seconds and minute input are valid
  /// values more than 0 and less than 60
  static bool validSecMin(String s) {
    int second = int.parse(s);
    return second < 60 && second >= 0;
  }
}
