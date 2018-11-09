import 'match.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:map_view/figure_joint_type.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/polygon.dart';
import 'package:map_view/polyline.dart';

const API_KEY = "AIzaSyCnU0dF2qUj8RyWqRT7kCeMHjfR0ZZkMb0";

class MatchMe extends StatefulWidget {
  @override
  State createState() => new _MatchMeState();
}

class _MatchMeState extends State<MatchMe> {


  MapView mapView = new MapView();
  CameraPosition cameraPosition;
  var compositeSubscription = new CompositeSubscription();
  var staticMapProvider = new StaticMapProvider(API_KEY);
  Uri staticMapUri;

  //Marker bubble
  List<Marker> _markers = <Marker>[
    new Marker(
      "1",
      "Ang Mo Kio Swimming Complex",
      1.3630284240099342,
      103.84966846799315,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "2",
      "Bishan Sports Centre",
      1.3545565651642257,
      103.85110509030098,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "3",
      "Bukit Batok Swimming Complex",
      1.3446241150344131,
      103.74820215309572,

      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "4",
      "Bukit Gombak Sports Centre",
      1.3585788859835228,
      103.75307208015458,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "5",
      "Bedok Sports Centre",
      1.326146507662457,
      103.93760139575777,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "6",
      "Burghley Squash and Tennis Centre",
      1.3592971242034178,
      103.86061120027034,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "7",
      "Choa Chu Kang Sports Centre",
      1.3909845276632207,
      103.74885245508918,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "8",
      "Jurong Stadium",
      103.71939554362339,
      1.3329599872251756,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "9",
      "Hougang Sports Centre",
      103.8867531706319,
      1.3695298889167231,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "10",
      "Clementi Stadium",
      1.309991383184705,
      103.76277689679644,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "11",
      "Clementi Sports Centre",
      1.3106359556234621,
      103.76534974310744,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "12",
      "Jurong West Sports Centre",
      1.33845299187024,
      103.69426650286917,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "13",
      "Kallang Basin Swimming Complex",
      1.3227582896906225,
      103.8725093253719,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "14",
      "Kallang Sports Centre",
      1.3056135872947556,
      103.87852830553813,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "15",
      "Katong Swimming Complex",
      1.3019423133919448,
      103.88578241029184,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "16",
      "Our Tampines Hub - Community Auditorium",
      1.3528135123304903,
      103.93980129089589,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "17",
      "Pasir Ris Sports Centre",
      1.3745061874727202,
      103.95188674193453,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "18",
      "Queenstown Sports Centre",
      1.2961648900338507,
      103.802541403801,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "19",
      "Sengkang Sports Centre",
      1.3961011937659396,
      103.88683725516032,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "20",
      "Serangoon Sports Centre",
      1.35674289294305,
      103.87457834334423,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "21",
      "Tampines Sports Centre",
      1.3550236785364302,
      103.9395248281798,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "22",
      "Toa Payoh Sports Centre",
      1.3306822033724404,
      103.85174469628674,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "23",
      "Woodlands Sports Centre",
      1.43491804162319,
      103.78000608975601,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "24",
      "St Wilfrid Sports Centre",
      1.325640816995,
      103.86166142603255,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "25",
      "Yio Chu Kang Sports Centre",
      1.3825985333897806,
      103.84642305838722,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "26",
      "Yishun Sports Centre",
      1.4121201704558521,
      103.83190674699676,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "27",
      "Co Curricular Activities Branch",
      1.3194549091211727,
      103.81910218250292,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "28",
      "Delta Sports Centre",
      1.289303302414192,
      103.82092439139942,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "29",
      "Enabling Village Gym",
      1.2869847104597365,
      103.81469321656817,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "30",
      "Geylang Field",
      1.3102021097171088,
      103.87776151377322,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "31",
      "Farrer Park Field and Tennis Centre",
      1.3111739491470247,
      103.84975579024662,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "32",
      "Jalan Besar Sports Centre",
      1.310570682850956,
      103.86017249298665,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
    new Marker(
      "33",
      "Jurong East Sports Centre",
      1.3465866159268447,
      103.72966521328205,
      color: Colors.blue,
      draggable: false, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
  ];

  //Line
  List<Polyline> _lines = <Polyline>[
    new Polyline(
        "11",
        <Location>[
          new Location(45.52309483308097, -122.67339684069155),
          new Location(45.52298442915803, -122.66339991241693),
        ],
        width: 15.0,
        color: Colors.blue),
  ];
  List<Polygon> polygons = <Polygon>[];
  /* setPolygons(){
    for (int i = 0; i<latitudes.length; i++){
      List<Location> coordinates = <Location>[];
        for(int j = 0; j<latitudes[i].length; j++){
          Location coordinate = new Location(latitudes[i][j],longitudes[i][j]);
          coordinates.add(coordinate);
      }
      Polygon polygon = new Polygon("test",coordinates,
        jointType: FigureJointType.bevel,
        strokeWidth: 5.0,
        strokeColor: Colors.red,
        fillColor: Color.fromARGB(75, 255, 0, 0));
      polygons.add(polygon);
    }
  } */
  //Drawing


  @override
  initState() {
    super.initState();
    cameraPosition = new CameraPosition(Location(1.3630284240099342,103.84966846799315), 2.0);
    staticMapUri = staticMapProvider.getStaticUri(Location(1.3630284240099342,103.84966846799315), 12,
        width: 900, height: 400, mapType: StaticMapViewType.roadmap);
  }
  Future _matchMe(BuildContext context) async {
    String forumName;
    String forumDesc;
    await showDialog(
      context: context,
      builder: (BuildContext context) => new Dialog(
        child: new SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              new Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 10.0,
                ),
                child: Text("Select date and time",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                    )),
                color: Color(0xFF1D4886),
              ),
              new Container(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    new Container(
                      padding: EdgeInsets.all(10.0),
                      child: FloatingActionButton(
                          onPressed: () {},
                          backgroundColor: Color(0xFF1D4886),
                          child: Icon(Icons.add_a_photo)),
                    ),
                    new Container(
                      padding: EdgeInsets.all(10.0),
                      child: new Text("Add a Picture"),
                    )
                  ],
                ),
              ),
              new Container(
                padding: EdgeInsets.all(5.0),
                child: new Card(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "Forum Name:",
                          style: TextStyle(
                            color: Color(0xFF1D4886),
                          ),
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: new TextField(
                          onChanged: (String name) {
                            forumName = name;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFF1D4886), width: 0.5)),
                          ),
                          maxLines: 2,
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          "Forum Description:",
                          style: TextStyle(
                            color: Color(0xFF1D4886),
                          ),
                        ),
                      ),
                      new Container(
                        padding: EdgeInsets.all(5.0),
                        child: new TextField(
                          onChanged: (String desc) {
                            forumDesc = desc;
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(0xFF1D4886), width: 0.5))),
                          maxLines: 6,
                        ),
                      ),
                      new Align(
                          alignment: Alignment.bottomRight,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              new FlatButton(
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text("GROUP",
                                      style: TextStyle(
                                          color: Color(0xFF1D4886)))),
                              new FlatButton(
                                  onPressed: () {
                                    print(forumName);
                                    print(forumDesc);
                                    if (forumName == null ||
                                        forumDesc == null) {
                                      showDialog(
                                        context: context,
                                        child: new AlertDialog(
                                          content: Text(
                                              "Please fill in required fields"),
                                          title:
                                          Text("Incomplete information"),
                                        ),
                                      );
                                    } else {
                                      /* DocumentReference documentReference =
                                            Firestore.instance
                                                .collection('forums')
                                                .document(forumName);
                                        Map<String, String> forumData =
                                            <String, String>{
                                          "name": forumName,
                                          "description": forumDesc,
                                          "imageURL":
                                              "https://d30zbujsp7ao6j.cloudfront.net/wp-content/uploads/2017/07/unnamed.png",
                                              "https://cdn-images-1.medium.com/max/1200/1*5-aoK8IBmXve5whBQM90GA.png",
                                          "count": "1",
                                        };
                                        documentReference
                                            .setData(forumData, merge: true)
                                            .whenComplete(() {
                                          print("forum created");
                                          //print(count.toString());
                                          //print(prevMessage);
                                        }).catchError((e) => print(e)); */
                                    }
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  },
                                  child: Text("SOLO",
                                      style: TextStyle(
                                          color: Color(0xFF1D4886)))),
                            ],
                          )),
                    ],
                  ),
                  color: Colors.grey[50],
                  elevation: 3.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Map View Example'),
          ),
          body: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                height: 250.0,
                child: new Stack(
                  children: <Widget>[
                    new Center(
                        child: new Container(
                          child: new Text(
                            "You are supposed to see a map here.\n\nAPI Key is not valid.\n\n"
                                "To view maps in the example application set the "
                                "API_KEY variable in example/lib/main.dart. "
                                "\n\nIf you have set an API Key but you still see this text "
                                "make sure you have enabled all of the correct APIs "
                                "in the Google API Console. See README for more detail.",
                            textAlign: TextAlign.center,
                          ),
                          padding: const EdgeInsets.all(20.0),
                        )),
                    new InkWell(
                      child: new Center(
                        child: new Image.network(staticMapUri.toString()),
                      ),
                      onTap: showMap,
                    )
                  ],
                ),
              ),
              new Container(
                padding: new EdgeInsets.only(top: 10.0),
                child: new Text(
                  "Tap the map to choose your location",
                  style: new TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              new Container(
                  padding: new EdgeInsets.only(top: 25.0),
                  child:
                  new Column(
                    children: <Widget>[
                      new Container(child:
                      location != null
                          ? Text(location)
                          : Text("Select your location"),
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Text("ENTER DATE HERE"),
                          new Text("ENTER TIMEE HERE"),
                        ],),
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new RaisedButton(
                            child: Text("SOLO"),
                          ),
                          new RaisedButton(
                            child: Text("GROUP"),
                          ),
                        ],
                      )
                    ],)
              ),
            ],
          )),
    );
  }
  String location;
  showMap() {
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            showMyLocationButton: true,
            showCompassButton: true,
            initialCameraPosition: new CameraPosition(
                new Location(1.3449742165657,103.747781014088), 15.0),
            hideToolbar: false,
            title: "Recently Visited"),
        toolbarActions: [new ToolbarAction("Close", 1)]);
    StreamSubscription sub = mapView.onMapReady.listen((_) {
      mapView.setMarkers(_markers);
      mapView.setPolylines(_lines);
      mapView.setPolygons(polygons);
    });
    compositeSubscription.add(sub);
    sub = mapView.onLocationUpdated.listen((location) {
      print("Location updated $location");
    });
    compositeSubscription.add(sub);
    sub = mapView.onTouchAnnotation
        .listen((annotation) {
      mapView.dismiss();
      location = annotation.title;
    });
    compositeSubscription.add(sub);
    sub = mapView.onTouchPolyline
        .listen((polyline) => print("polyline ${polyline.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onTouchPolygon
        .listen((polygon) => print("polygon ${polygon.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onMapTapped
        .listen((location) { print("Touched location $location");
    });
    compositeSubscription.add(sub);
    sub = mapView.onCameraChanged.listen((cameraPosition) =>
        this.setState(() => this.cameraPosition = cameraPosition));
    compositeSubscription.add(sub);
    sub = mapView.onAnnotationDragStart.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging started");
    });
    sub = mapView.onAnnotationDragEnd.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging ended");
    });
    sub = mapView.onAnnotationDrag.listen((markerMap) {
      var marker = markerMap.keys.first;
      var location = markerMap[marker];
      print("Annotation ${marker.id} moved to ${location.latitude} , ${location
          .longitude}");
    });
    compositeSubscription.add(sub);
    sub = mapView.onToolbarAction.listen((id) {
      print("Toolbar button id = $id");
      if (id == 1) {
        _handleDismiss();
      }
    });
    compositeSubscription.add(sub);
    sub = mapView.onInfoWindowTapped.listen((marker) {
      print("Info Window Tapped for ${marker.title}");
    });
    compositeSubscription.add(sub);
  }

  _handleDismiss() async {
    double zoomLevel = await mapView.zoomLevel;
    Location centerLocation = await mapView.centerLocation;
    List<Marker> visibleAnnotations = await mapView.visibleAnnotations;
    List<Polyline> visibleLines = await mapView.visiblePolyLines;
    List<Polygon> visiblePolygons = await mapView.visiblePolygons;
    print("Zoom Level: $zoomLevel");
    print("Center: $centerLocation");
    print("Visible Annotation Count: ${visibleAnnotations.length}");
    print("Visible Polylines Count: ${visibleLines.length}");
    print("Visible Polygons Count: ${visiblePolygons.length}");
    var uri = await staticMapProvider.getImageUriFromMap(mapView,
        width: 900, height: 400);
    setState(() => staticMapUri = uri);
    mapView.dismiss();
    compositeSubscription.cancel();
  }

}

class CompositeSubscription {
  Set<StreamSubscription> _subscriptions = new Set();

  void cancel() {
    for (var n in this._subscriptions) {
      n.cancel();
    }
    this._subscriptions = new Set();
  }

  void add(StreamSubscription subscription) {
    this._subscriptions.add(subscription);
  }

  void addAll(Iterable<StreamSubscription> subs) {
    _subscriptions.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return this._subscriptions.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return this._subscriptions.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return this._subscriptions.toList();
  }
}
