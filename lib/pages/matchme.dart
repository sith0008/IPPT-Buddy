import 'package:flutter/material.dart';
import 'match.dart';

class MatchMe extends StatefulWidget {
  @override
  State createState() => new _MatchMeState();
}

class _MatchMeState extends State<MatchMe> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Column(
        children: <Widget>[
          new Container(
            color: new Color(0xFFED2939),
            padding: new EdgeInsets.all(10.0),
            child: new Row(
              children: <Widget>[
                new Text('Choose Your Location',
                    style: new TextStyle(fontSize: 30.0, color: Colors.white))
              ],
            ),
          ),
          new Container(child: new Image.asset('assets/map.png')),
          new Card(
              child: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text('8th September 2018',
                      style: new TextStyle(
                        fontSize: 30.0,
                      ))
                ],
              ),
              new Row(
                children: <Widget>[
                  new Text('18:30',
                      style: new TextStyle(
                        fontSize: 30.0,
                      ))
                ],
              ),
            ],
          )),
          new ButtonTheme(
              minWidth: 300.0,
              child: new FlatButton(
                child: new Text('Match Me',
                    style: new TextStyle(
                      fontSize: 20.0,
                    )),
                color: new Color(0xFFED2939),
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Match()));
                },
              ))
        ],
      ),
    );
  }
}
