import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ipptbuddy/controllers/chat_controller.dart';

///iOS theme
final ThemeData iOSTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
);

///Android theme
final ThemeData androidTheme = new ThemeData(
  primarySwatch: Colors.blue,
  primaryColor: Colors.white,
  primaryColorBrightness: Brightness.light,
);

class ChatGroup extends StatefulWidget {
  final String groupName;
  @override
  ChatGroup(this.groupName);
  @override
  State createState() => new ChatGroupScreen(groupName);
}

class ChatGroupScreen extends State<ChatGroup> with TickerProviderStateMixin {
  final String groupName;
  ChatGroupScreen(this.groupName);
  final TextEditingController _textController = new TextEditingController();
  bool _isWriting = false;
  final ScrollController listScrollController = new ScrollController();

  ChatController cc = new ChatController();
  SharedPreferences prefs;
  String id;
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }

  @override
  Widget build(BuildContext ctx) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(groupName, style: new TextStyle(fontSize: 16.0)),
        iconTheme: IconThemeData(
          color: new Color(0xFFED2939),
        ),
        backgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: new Color(0xFFED2939),
              displayColor: new Color(0xFFED2939),
              fontFamily: 'Garamond',
            ),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 6.0,
      ),
      body: new Column(children: <Widget>[
        new Flexible(
            child: new StreamBuilder(
                stream: ChatController.getGroupChatMessages(groupName),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return const Text('Loading...');
                  return new ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      padding: const EdgeInsets.all(6.0),
                      itemBuilder: (context, index) => _buildListItem(
                          context, snapshot.data.documents[index]),
                      reverse: true,
                      controller: listScrollController);
                })),
        new Divider(height: 1.0),
        new Container(
          child: _buildComposer(),
          decoration: new BoxDecoration(color: Theme.of(ctx).cardColor),
        ),
      ]),
    );
  }

  ///Builds keyboard if user presses on text field
  Widget _buildComposer() {
    readLocal();
    return new IconTheme(
      data: new IconThemeData(color: Theme.of(context).accentColor),
      child: new Container(
          margin: const EdgeInsets.symmetric(horizontal: 9.0),
          child: new Row(
            children: <Widget>[
              new Flexible(
                child: new TextField(
                  controller: _textController,
                  decoration: InputDecoration.collapsed(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey)),
                  onChanged: (String txt) {
                    setState(() {
                      _isWriting = txt.length > 0;
                    });
                  },
                  onSubmitted: _submitMsg,
                ),
              ),
              new Container(
                  margin: new EdgeInsets.symmetric(horizontal: 3.0),
                  child: Theme.of(context).platform == TargetPlatform.iOS
                      ? new CupertinoButton(
                          child: new Text("Submit"),
                          onPressed: _isWriting
                              ? () => _submitMsg(_textController.text)
                              : null)
                      : new IconButton(
                          icon: new Icon(Icons.send),
                          onPressed: _isWriting
                              ? () => _submitMsg(_textController.text)
                              : null,
                        )),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? new BoxDecoration(
                  border: new Border(top: new BorderSide(color: Colors.brown)))
              : null),
    );
  }

  ///Send message onto group
  void _submitMsg(String txt) {
    List<DocumentSnapshot> databaseDocuments = ChatController.getAllUsers(id);
    String userName = databaseDocuments[0]['Name'];
    String photoURL = databaseDocuments[0]['imageURL'];
    _textController.clear();
    setState(() {
      _isWriting = false;
    });
    ChatController.createGroupChatMessageFirebase(
        txt, groupName, userName, photoURL);
    listScrollController.animateTo(0.0,
        duration: Duration(milliseconds: 300), curve: Curves.easeOut);
  }

  ///Builds a list of group chats available
  Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
    return new Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
                margin: const EdgeInsets.only(right: 18.0),
                child: new CircleAvatar(
                    backgroundImage: new NetworkImage(document['photoURL']))),
            new Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(document['displayName'],
                      style: new TextStyle(fontWeight: FontWeight.bold)),
                  new Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    child: new Text(document['content']),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
