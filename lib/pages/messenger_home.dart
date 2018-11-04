import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './chat.dart';

final ThemeData iOSTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
);

final ThemeData androidTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
);

class MessengerHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MessengerHomeState();
  }
}

class MessengerHomeState extends State<MessengerHome> {
  SharedPreferences prefs;
  String id;
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    readLocal();
    return new Container(
        child: new StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .document(id)
                .collection('chatUsers')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text('Loading...');
              return snapshot.data != null
                  ? new ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      padding: const EdgeInsets.only(top: 10.0),
                      itemExtent: 70.0,
                      itemBuilder: (context, index) =>
                          _buildChats(context, snapshot.data.documents[index]),
                    )
                  : new Container();
            }));
  }
}

Widget _buildChats(BuildContext context, DocumentSnapshot document) {
  return new ListTile(
      leading: new CircleAvatar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.blue[100],
        backgroundImage: new NetworkImage(document['photoURL']),
      ),
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new Text(
            document['displayName'],
            style: new TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
      subtitle: new Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: new Text(document['aboutMe'],
            style: new TextStyle(fontWeight: FontWeight.bold)),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                Chat(peerId: document['id'], peerName: document['displayName']),
          ),
        );
      });
}
