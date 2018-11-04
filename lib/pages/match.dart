import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Match extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MatchState();
  }
}

class _MatchState extends State<Match> {
  void _info() {
    infoDialog(context).then((bool value) {});
  }

  Future<bool> infoDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("MatchMe Information"),
            content: new Text(
                "Scroll through the list of other users to find a buddy!" +
                    " Once you found a user that you want to chat with simply press 'chat' to chat and find out more about each other!"),
            actions: <Widget>[
              new FlatButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: new Color(0xFFED2939),
          ),
          title: Text('MatchMe'),
          backgroundColor: Colors.white,
          textTheme: Theme.of(context).textTheme.apply(
              bodyColor: new Color(0xFFED2939),
              displayColor: new Color(0xFFED2939),
              fontFamily: 'Garamond'),
        ),
        body: Container(
            color: Colors.grey[200],
            child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Expanded(
                      child: new Container(
                          padding: new EdgeInsets.only(top: 10.0),
                          child: new Card(
                              child: new Row(
                            children: <Widget>[
                              new Expanded(
                                  child: new Padding(
                                      padding: new EdgeInsets.all(8.0),
                                      child: new Text('Find Your IPPT Buddy!',
                                          style: new TextStyle(
                                              fontFamily: 'Raleway',
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold))),
                                  flex: 4),
                              new Expanded(
                                  child: new IconButton(
                                      icon: new Icon(Icons.info),
                                      onPressed: () {
                                        _info();
                                      }),
                                  flex: 1)
                            ],
                          ))),
                      flex: 1),
                  new Expanded(
                      child: new Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child:
                              new Stack(children: <Widget>[ShowInfo(context)])),
                      flex: 5)
                ])));
  }
}

class ShowInfo extends StatefulWidget {
  final BuildContext context;
  ShowInfo(this.context);
  @override
  ShowInfoState createState() => ShowInfoState(context);
}

class ShowInfoState extends State<ShowInfo> {
  BuildContext context;
  ShowInfoState(this.context);
  int _activeMeterIndex;
  List<DocumentSnapshot> databaseDocuments;
  List<DocumentSnapshot> usersDocuments;

  SharedPreferences prefs;
  String id;
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }

  void _confirm() {
    confirmDialog(context).then((bool value) {});
  }

  readData() async {
    final QuerySnapshot result = await Firestore.instance
        .collection('users')
        .where('id', isEqualTo: id)
        .getDocuments();
    databaseDocuments = result.documents;
  }

  readUsers() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('users').getDocuments();
    usersDocuments = result.documents;
  }

  Future<bool> confirmDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("User Added"),
            content: new Text("This passenger has been added to your chats!"),
            actions: <Widget>[
              new FlatButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  List<DocumentSnapshot> userDocuments;
  readUser() async {
    final QuerySnapshot result =
        await Firestore.instance.collection('users').getDocuments();
    userDocuments = result.documents;
  }

//new new new
  @override
  Widget build(BuildContext context) {
    readData();
    readLocal();
    return Container(
        child: new StreamBuilder(
            stream: Firestore.instance.collection('users').snapshots(),
            builder: (context, stream) {
              if (!stream.hasData) return const Text('Loading...');
              return stream.data != null
                  ? new ListView.builder(
                      itemCount: stream.data.documents.length,
                      padding: const EdgeInsets.only(top: 10.0),
                      itemBuilder: (BuildContext context, int i) {
                        return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            elevation: 3.0,
                            margin: const EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 0.0),
                            child: new GestureDetector(
                                onTap: () {
                                  _confirm();
                                  String chatId =
                                      stream.data.documents[i]['id'];
                                  DocumentReference documentReference =
                                      Firestore.instance
                                          .collection('users')
                                          .document(id)
                                          .collection('chatUsers')
                                          .document(chatId);
                                  Map<String, String> profilesData =
                                      <String, String>{
                                    "displayName": stream.data.documents[i]
                                        ['name'],
                                    "id": stream.data.documents[i]['id'],
                                    "photoURL": stream.data.documents[i]
                                        ['imageURL'],
                                    "aboutMe": "I am your IPPT buddy!",
                                  };
                                  documentReference
                                      .setData(profilesData, merge: true)
                                      .whenComplete(() {
                                    print("chat created");
                                  }).catchError((e) => print(e));
                                  print(databaseDocuments[0]['id']);
                                  DocumentReference documentReference2 =
                                      Firestore.instance
                                          .collection('users')
                                          .document(chatId)
                                          .collection('chatUsers')
                                          .document(id);
                                  Map<String, String> profilesData2 =
                                      <String, String>{
                                    "displayName": databaseDocuments[0]['name'],
                                    "id": databaseDocuments[0]['id'],
                                    "photoURL": databaseDocuments[0]
                                        ['imageURL'],
                                    "aboutMe": "I am your IPPT buddy!",
                                  };
                                  documentReference2
                                      .setData(profilesData2, merge: true)
                                      .whenComplete(() {
                                    print("other chat created");
                                  }).catchError(
                                          (e) => print("Errorrrrrrrrrrrr" + e));
                                  Navigator.of(context).pop(true);
                                },
                                child: new ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: new NetworkImage(
                                        stream.data.documents[i]['imageURL']),
                                    radius: 28.0,
                                  ),
                                  title: Container(
                                    padding: EdgeInsets.only(bottom: 6.0),
                                    child:
                                        Text(stream.data.documents[i]['name'],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF1D4886),
                                              fontSize: 15.0,
                                            ),
                                            overflow: TextOverflow.clip),
                                  ),
                                  subtitle: Text("2.4km: 10:50"),
                                )));
                      })
                  : new Container();
            }));
  }
}
