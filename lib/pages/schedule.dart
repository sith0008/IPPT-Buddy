import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import './schedule_controller.dart';
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
  ScheduleController scheduleController = new ScheduleController();
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
                title: new Text(document['name']),
                subtitle: new Text(document['rep'].toString()),
                value: document['checked'],
                onChanged: (bool value) {
                  setState(() {
                    scheduleController.scheduleRef(value, document['name'], id);
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
                        color: new Color(0xFFED2939),
                        child: new Container(
                          alignment: FractionalOffset(0.1, 0.5),
                            child: new Text("Window Closes: 20 Dec 2018",
                                style: new TextStyle(
                                  color: Colors.white,
                                    fontFamily: 'Raleway',
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold
                                    ))),
                      ),
                  flex: 1),
              new Expanded(
                  child: new Container(
                      child: new Card(
                        color: Colors.white,
                        child: new Center(
                            child: new Text(formatDate(new DateTime.now(), [dd, ' ', M, ' ', yyyy]).toString(),
                                style: new TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold))),
                      )),
                  flex: 2),
              new Expanded(
                  child: new StreamBuilder(
                      stream: scheduleController.scheduleSnapshots(id),
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
