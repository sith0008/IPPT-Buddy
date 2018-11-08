import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './chat.dart';
import 'chat_controller.dart';


///UI theme for iOS
final ThemeData iOSTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
);

///UI theme for android
final ThemeData androidTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
);

///UI class to display the list of chats to the user
class MessengerHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MessengerHomeState();
  }
}

///UI state which updates whenever database is changed
class MessengerHomeState extends State<MessengerHome> {
  SharedPreferences prefs;
  String id;


  ///Get user's id from SharedPreference
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    print(id);
    setState(() {});
  }

  ///Build list of chats, display 'loading' if firestore has yet to return any ReferenceDocument
  @override
  Widget build(BuildContext context) {
    readLocal();
    return new Container(
        child: new StreamBuilder(
            stream: ChatController.getChatuserList(id),
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
            })
    );
  }
}

///Build and dsiplay list of chats to user
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
