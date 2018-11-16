import 'dart:async';

import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:ipptbuddy/controllers/profiles_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// UI Widget to display profile settings
class Profiles extends StatefulWidget {
  @override
  _ProfilesState createState() => _ProfilesState();
}

/// Widget to display input box for profile settings
class _ProfilesState extends State<Profiles> {
  // Classes used
  SharedPreferences prefs;

  // Variables required
  String id;
  var _image;
  var image;
  String _min;
  String _sec;
  String _nickName;
  String _pushUp;
  String _sitUp;
  List<String> _awards = new List<String>();
  String _award;
  String _time;
  String _dateValue = '';

  /// Get user's id from sharedPreference
  readLocal() async {
    prefs = await SharedPreferences.getInstance();
    id = prefs.getString("id").toString() ?? '';
    setState(() {});
  }

  @override
  void initState() {
    _awards.addAll(["Gold", "Silver", "Pass"]);
  }

  /// Call camera application
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  /// Change value of award
  void _onChangedAward(String value) {
    setState(() {
      _award = value;
    });
  }

  /// Get image for storing
  void _getImage() {
    setState(() {
      _image = image;
    });
  }

  ///Let user select date using date picker pop up.
  ///Function runs the date picker popup
  Future _selectDate() async {
    DateTime picked = await showDatePicker(
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime(2018),
        lastDate: new DateTime(2020));
    if (picked != null)
      setState(() =>
          _dateValue = formatDate(picked, [dd, ' ', M, ' ', yyyy]).toString());
  }

  /// Function to call confirm dialog
  void _confirm() {
    confirmDialog(context).then((bool value) {});
  }

  /// confirm dialog to notify user that profile has been updated
  Future<bool> confirmDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Saved!"),
            content: new Text("Your profile has been updated!"),
            actions: <Widget>[
              new FlatButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  /// Function to call null dialog
  void _confirmNull() {
    nullDialog(context).then((bool value) {});
  }

  /// null dialog to prompt user to fill up all fields before saving
  Future<bool> nullDialog(BuildContext context) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text("Sorry"),
            content: new Text("Please fill up all the fields in the form!"),
            actions: <Widget>[
              new FlatButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              )
            ],
          );
        });
  }

  /// Build an external scaffold to hold the contents of profile and settings
  /// Widget to build the profile and settings form for user to fill
  @override
  Widget build(BuildContext context) {
    readLocal();
    return new Scaffold(
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
                        onPressed: () {
                          getImage();
                        },
                        child: Icon(Icons.add_a_photo)),
                  ),
                  new Text(
                    'Add Profile Picture',
                    style: TextStyle(),
                  ),
                  new Container(
                      padding: new EdgeInsets.all(10.0),
                      child: new TextField(
                        onChanged: (String n) {
                          setState(() {
                            _nickName = n;
                          });
                        },
                        decoration:
                            InputDecoration(labelText: 'Enter your nickname'),
                      )),
                ],
              ),
            ),
            new Card(
              child: Column(
                children: <Widget>[
                  new Padding(
                      padding: new EdgeInsets.all(10.0),
                      child: new Text('IPPT Results',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold))),
                  new ListTile(
                      leading: new Column(
                        children: <Widget>[
                          new Container(
                              width: 80.0,
                              child: new Text(
                                '2.4km Run',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      title: new Row(children: <Widget>[
                        new Expanded(
                          child: new TextField(
                            onChanged: (String m) {
                              // check if min input is less than 60
                              if (ProfilesController.validSecMin(m)) {
                                setState(() {
                                  _min = m;
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                labelText: 'Mins',
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal))),
                          ),
                          flex: 2,
                        ),
                        new Expanded(
                          child: new Center(child: new Text('  :  ')),
                          flex: 1,
                        ),
                        new Expanded(
                          child: new TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (String s) {
                              // check if sec input is less than 60
                              if (ProfilesController.validSecMin(s)) {
                                setState(() {
                                  _sec = s;
                                });
                              }
                            },
                            decoration: InputDecoration(
                                labelText: 'Sec',
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.teal))),
                          ),
                          flex: 2,
                        )
                      ])),
                  new ListTile(
                    leading: new Column(
                      children: <Widget>[
                        new Container(
                            width: 80.0,
                            child: new Text(
                              'Push-Ups',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    title: new TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String p) {
                        setState(() {
                          _pushUp = p;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Reps',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal))),
                    ),
                  ),
                  new ListTile(
                    leading: new Column(
                      children: <Widget>[
                        new Container(
                            width: 80.0,
                            child: new Text(
                              'Sit-Ups',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                    title: new TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (String s) {
                        setState(() {
                          _sitUp = s;
                        });
                      },
                      decoration: InputDecoration(
                          labelText: 'Reps',
                          border: new OutlineInputBorder(
                              borderSide: new BorderSide(color: Colors.teal))),
                    ),
                  ),
                  new ListTile(
                      leading: new Column(
                        children: <Widget>[
                          new Container(
                            width: 80.0,
                            child: new Text(
                              'Target Result',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      title: new Container(
                          child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                                value: _award,
                                items: _awards.map((String value) {
                                  return new DropdownMenuItem(
                                    value: value,
                                    child: new Row(children: <Widget>[
                                      new Text('${value}'),
                                    ]),
                                  );
                                }).toList(),
                                onChanged: (String value) {
                                  _onChangedAward(value);
                                })),
                      ))),
                  new ListTile(
                    leading: new Column(
                      children: <Widget>[
                        new Container(
                          width: 80.0,
                          child: new Text(
                            'IPPT Date',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    title: new Container(
                      decoration: new BoxDecoration(
                          border: new Border.all(color: Colors.black)),
                      child: new FlatButton(
                          onPressed: _selectDate,
                          color: Colors.white,
                          child: _dateValue != ''
                              ? Text(_dateValue)
                              : new Text('Set Date')),
                    ),
                  )
                ],
              ),
            ),
            new Card(
                color: new Color(0xFFED2939),
                child: new ButtonTheme(
                    minWidth: 300.0,
                    child: FlatButton(
                      onPressed: () {
                        if (ProfilesController.fieldFilled(_nickName, _min,
                            _sec, _award, _pushUp, _sitUp, _dateValue)) {
                          _time = ProfilesController.findTiming(_min, _sec);
                          // Call Profiles Controller to update profile infomation on database
                          ProfilesController.updateProfile(
                              _nickName,
                              _time,
                              _pushUp,
                              _sitUp,
                              _award,
                              _dateValue,
                              id,
                              _min,
                              _sec);
                          // Call profile controller to update schedule data on database
                          ProfilesController.updateSchedule(
                              _pushUp, _sitUp, _min, _sec, id);
                          Navigator.of(context).pop(true);
                          _confirm();
                        } else {
                          _confirmNull();
                        }
                      },
                      textColor: Colors.white,
                      color: Color(0xFFED2939),
                      child: new Text(
                        "SAVE",
                      ),
                    ))),
          ],
        )),
      ),
    );
  }
}
