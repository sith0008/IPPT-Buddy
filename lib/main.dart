import 'package:flutter/material.dart';
import 'package:ipptbuddy/controllers/root_page.dart';
import 'package:ipptbuddy/controllers/auth.dart';
import 'package:flutter/services.dart';
import 'package:map_view/map_view.dart';

/// API key for google maps.
const API_KEY = "AIzaSyCnU0dF2qUj8RyWqRT7kCeMHjfR0ZZkMb0";

/// main method ran at start of application
void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    MapView.setApiKey(API_KEY);
    runApp(new MaterialApp(home: new App()));
  });
}

/// Widget class to build the application
class App extends StatelessWidget {
  /// This widget is the root of the application.
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
