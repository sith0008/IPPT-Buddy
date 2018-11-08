import 'package:flutter/material.dart';
import './matchme.dart' as match;
import './schedule.dart' as schedule;
import './messenger_home.dart' as chat;
import './profiles.dart' as profiles;
import '../auth.dart';
import 'home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  Home({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;
  @override
  MyTabsState createState() => new MyTabsState(auth: auth, onSignOut: onSignOut);
}

class MyTabsState extends State<Home> with SingleTickerProviderStateMixin {
  MyTabsState({this.auth, this.onSignOut});
  final BaseAuth auth;
  final VoidCallback onSignOut;
  SharedPreferences prefs;
  String id;
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }
  final List<MyTabs> _tabs = [
    new MyTabs(title: "IPPT Buddy"),
    new MyTabs(title: "MatchMe"),
    new MyTabs(title: "Chat")
  ];

  MyTabs handler;
  TabController controller;

  @override
  void initState() {
    super.initState();
    controller = new TabController(vsync: this, length: 3, initialIndex: 0);
    handler = _tabs[1];
    controller.addListener(handleSelected);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void handleSelected() {
    setState(() {
      handler = _tabs[controller.index];
    });
  }

  @override
  Widget build(BuildContext context) {
    readLocal();
    void _signOut() async {
      try {
        await auth.signOut();
        onSignOut();
      } catch (e) {
        print(e);
      }

    }
    return new Scaffold(
        appBar: new AppBar(
            title: new Text(handler.title),
            backgroundColor: Colors.white,
            textTheme: Theme.of(context).textTheme.apply(
                  bodyColor: new Color(0xFFED2939),
                  displayColor: new Color(0xFFED2939),
                  fontFamily: 'Garamond',
                ),
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.account_circle),
                color: new Color(0xFFED2939),
                tooltip: 'Profiles',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => profiles.Profiles()));
                },
              ),
              new IconButton(
                icon: new Icon(Icons.exit_to_app),
                color: new Color(0xFFED2939),
                tooltip: 'Sign out',
                onPressed: () {
                  _signOut();
                },
              ),
            ]),
        bottomNavigationBar: new Material(
            color: Colors.white,
            child: new TabBar(
                controller: controller,
                tabs: <Tab>[
                  new Tab(icon: new Icon(Icons.timer)),
                  new Tab(icon: new Icon(Icons.group)),
                  new Tab(icon: new Icon(Icons.message))
                ],
                indicatorColor: new Color(0xFFED2939),
                labelColor: new Color(0xFFED2939),
                unselectedLabelColor: Colors.grey)),
        body: new TabBarView(controller: controller, children: <Widget>[
          new schedule.Schedule(),
          new match.MatchMe(),
          new chat.MessengerHome()
        ]));
  }
}

class MyTabs {
  final String title;
  MyTabs({this.title});
}
