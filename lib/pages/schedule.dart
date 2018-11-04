import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() {
    return ScheduleState();
  }
}

class ScheduleState extends State<Schedule> {
  SharedPreferences prefs;
  String id;
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new Container(
      child: new Container(
        child: new Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
            child: new CheckboxListTile(
                title: Text(document['name']),
                secondary: Text(document['rep']),
                value: document['checked'],
                onChanged: (bool value) {
                  setState(() {
                    DocumentReference itemRef = Firestore.instance.document(
                        "users/" + id + "/schedule/" + document['name']);
                    Map<String, bool> data = <String, bool>{
                      "checked": value,
                    };
                    itemRef
                        .setData(data, merge: true)
                        .whenComplete(() {})
                        .catchError((e) => print(e));
                  });
                })),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    readLocal();
    return new Container(
        color: Colors.grey[200],
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Expanded(
                  child: new Container(
                      padding: new EdgeInsets.only(top: 10.0),
                      child: new Card(
                        color: Colors.white,
                        child: new Center(
                            child: new Text(new DateTime.now().toString(),
                                style: new TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold))),
                      )),
                  flex: 2),
              new Expanded(
                  child: new StreamBuilder(
                      stream: Firestore.instance
                          .collection('users')
                          .document(id)
                          .collection('schedule')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text('Loading...');
                        return new ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          padding: const EdgeInsets.only(top: 10.0),
                          itemBuilder: (context, index) => _buildListItem(
                              context, snapshot.data.documents[index]),
                        );
                      }),
                  flex: 8)
            ]));
  }
}
