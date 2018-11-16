import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ipptbuddy/controllers/match_controller.dart';

/// UI widget to display page with scaffold and appbar
/// Takes in parameter of location and date
class MatchUsers extends StatefulWidget {
  final String location;
  final String date;
  @override
  MatchUsers({Key key, @required this.location, @required this.date})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _MatchUsersState(location: location, date: date);
  }
}

/// Widget to display scaffold and appbar
/// Takes in parameter of location and date
class _MatchUsersState extends State<MatchUsers> {
  final String location;
  final String date;
  @override
  _MatchUsersState({Key key, @required this.location, @required this.date});

  // Classes used
  SharedPreferences prefs;

  // Variables required
  String id;

  // Function to call info dialog
  void _info() {
    infoDialog(context).then((bool value) {});
  }

  // info dialog to give information on the page and how to use the page
  Future<bool> infoDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("MatchMe Information"),
            content: new Text(
                "Scroll through the list of other users to find a buddy!" +
                    " Once you found a user that you want to chat with simply tap on his profile to add him to your chats!"),
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

  //Get user's id from sharedPreference
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }

  // Build an external Scaffold to hold the contents of list of users
  @override
  Widget build(BuildContext context) {
    readLocal();
    return new Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context, true);
                MatchController.updateProfile(id, location, date);
              }),
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
                                      child: new Text('Find your IPPT Buddy!',
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
                          child: new Stack(children: <Widget>[
                            ShowInfo(context, location, date)
                          ])),
                      flex: 5)
                ])));
  }
}

/// UI widget class to display list of users to match
/// Takes in parameter of context, location and date
class ShowInfo extends StatefulWidget {
  final BuildContext context;
  final String location;
  final String date;
  ShowInfo(this.context, this.location, this.date);
  @override
  ShowInfoState createState() => ShowInfoState(context, location, date);
}

/// Widget to display lists of users
/// Takes in parameter of context, location and date
class ShowInfoState extends State<ShowInfo> {
  final String location;
  final String date;
  ShowInfoState(this.context, this.location, this.date);

  // Classes used
  BuildContext context;
  SharedPreferences prefs;

  // Variables required
  String id;

  //Get user's id from sharedPreference
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }

  // Function to call confirmation dialog
  void _confirm() {
    confirmDialog(context).then((bool value) {});
  }

  // Confirmation dialog to inform user that user is added to his chats when he press the 'chat' button
  Future<bool> confirmDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("User Added"),
            content: new Text("This user has been added to your chats!"),
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

  // Widget to build list of users, display 'loading' if firestore has yet to return any ReferenceDocument
  @override
  Widget build(BuildContext context) {
    readLocal();
    return Container(
        child: new StreamBuilder<QuerySnapshot>(
            stream: MatchController.userSnapshots(id, location, date),
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
                                  Navigator.of(context).pop(true);
                                  _confirm();
                                  MatchController.updateProfile(
                                      id, location, date);
                                  String chatId =
                                      stream.data.documents[i]['id'];
                                  MatchController.addUserToChat(
                                      id, chatId, stream.data.documents[i]);
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
                                  subtitle: Text('2.4km timing: ' +
                                      stream.data.documents[i]['matchRun']),
                                )));
                      })
                  : new Container();
            }));
  }
}
