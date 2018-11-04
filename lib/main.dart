import 'package:flutter/material.dart';
import './pages/login_page.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MaterialApp(home: new App()));
  });
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AirVenue',
      home: LoginPage()
    );
    // return AuthProvider(
    //   auth: Auth(),
    //   child: MaterialApp(
    //     title: 'AirVenue',
    //     home: LoginPage(),
    //   ),
    // );
  }
}
