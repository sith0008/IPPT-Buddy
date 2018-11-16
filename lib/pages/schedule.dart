import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:ipptbuddy/controllers/schedule_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// UI widget class to display training schedule for user to follow, also act as a to-do list
class Schedule extends StatefulWidget {
  const Schedule({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State<StatefulWidget> createState() {
    return ScheduleState();
  }
}

/// Widget to display training schedule and to-do list
class ScheduleState extends State<Schedule> {
  // Variables required
  String id;

  // Classes used
  SharedPreferences prefs;

  /// Get user's id from sharedPreference
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }

  /// Widget to build each schedule
  /// Display exercise name on the left
  /// Display number of repitions below exercise name
  /// Display checked box on the right
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new Container(
        child: document != null
            ? new Container(
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
                            ScheduleController.scheduleRef(
                                value, document['name'], id);
                          });
                        })),
              )
            : new Container(
                child: new Center(
                    child: new Text(
                        'Please press the profile button on the AppBar to fill up your profile!',
                        style: new TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0))),
              ));
  }

  /// Build container widget to hold the contents of schedules list
  /// display 'loading' if firestore has yet to return any ReferenceDocument
  @override
  Widget build(BuildContext context) {
    readLocal();
    String date = ScheduleController.dateRef(id);
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
                          child: date != null
                              ? new Text("Window Closes: " + date,
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Raleway',
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.bold))
                              : new Container(
                                  child: new Center(
                                      child: new Text(
                                          'Please press the profile button on the AppBar to fill up your profile!',
                                          style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0))),
                                ))),
                  flex: 1),
              new Expanded(
                  child: new Container(
                      child: new Card(
                    color: Colors.white,
                    child: new Center(
                        child: new Text(
                            formatDate(
                                    new DateTime.now(), [dd, ' ', M, ' ', yyyy])
                                .toString(),
                            style: new TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold))),
                  )),
                  flex: 2),
              new Expanded(
                  child: new StreamBuilder(
                      stream: ScheduleController.scheduleSnapshots(id),
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
