import 'package:flutter/material.dart';
import 'home.dart';
//import 'package:sticky_headers/sticky_headers.dart';
import 'package:image_picker/image_picker.dart';

class Profiles extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

class _ProfilesState extends State<Profiles> {
  var _image;
  var image;
/*
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    }); 
  }*/

  void _getImage() {
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: new Color(0xFFED2939),
        ),
        title: Text('Profile'),
        backgroundColor: Colors.white,
        textTheme: Theme.of(context).textTheme.apply(
            bodyColor: new Color(0xFFED2939),
            displayColor: new Color(0xFFED2939),
            fontFamily: 'Garamond'),
      ),
      body: SingleChildScrollView(
        child: new Center(
            child: new Column(
          children: <Widget>[
            new Card(
              child: Column(
                children: <Widget>[
                  new Container(
                    padding: new EdgeInsets.all(10.0),
                    child: new FloatingActionButton(
                        heroTag: 1,
                        backgroundColor: new Color(0xFF1D4886),
                        onPressed: () {},
                        child: Icon(Icons.add_a_photo)),
                  ),
                  new Text(
                    'Add Profile Picture',
                    style: TextStyle(),
                  ),
                  new Container(
                      padding: new EdgeInsets.all(10.0),
                      child: new TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Enter your nickname'),
                      )),
                ],
              ),
            ),
            new Card(
              child: Column(
                children: <Widget>[
                  new Text('IPPT Results'),
                  new ListTile(
                    leading: new Column(
                      children: <Widget>[
                        new Text(
                          '2.4km Run',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    title: new TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Timing',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal))),
                    ),
                  ),
                  new ListTile(
                    leading: new Column(
                      children: <Widget>[
                        new Text(
                          'Push-Ups',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    title: new TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Reps',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal))),
                    ),
                  ),
                  new ListTile(
                    leading: new Column(
                      children: <Widget>[
                        new Text(
                          'Sit-Ups',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    title: new TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Reps',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal))),
                    ),
                  ),
                  new ListTile(
                    leading: new Column(
                      children: <Widget>[
                        new Text(
                          'Target Result',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    title: new TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Award',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal))),
                    ),
                  ),
                  new ListTile(
                    leading: new Column(
                      children: <Widget>[
                        new Text(
                          'IPPT Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    title: new TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Set Date',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal))),
                    ),
                  ),
                ],
              ),
            ),
            new Card(
                color: new Color(0xFFED2939),
                child: new ButtonTheme(
                    minWidth: 300.0,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      textColor: Colors.white,
                      color: Colors.red,
                      child: new Text(
                        "SAVE",
                      ),
                    ))),
          ],
        )),
      ),
    ));
  }
}
