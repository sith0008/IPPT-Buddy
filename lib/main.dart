import 'package:flutter/material.dart';
import './root_page.dart';
import './auth.dart';
import 'package:flutter/services.dart';
import 'package:map_view/map_view.dart';

const API_KEY = "AIzaSyCnU0dF2qUj8RyWqRT7kCeMHjfR0ZZkMb0";

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    MapView.setApiKey(API_KEY);
    runApp(new MaterialApp(home: new App()));
  });
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'IPPT Buddy',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: new RootPage(auth: new Auth()),
    );
  }
}