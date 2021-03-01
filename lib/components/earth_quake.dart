import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import './earthquake_model.dart';
import './network.dart';

class EarthQuakeApp extends StatefulWidget {
  @override
  _EarthQuakeAppState createState() => _EarthQuakeAppState();
}

class _EarthQuakeAppState extends State<EarthQuakeApp> {
  Future<EarthQuake> _earthQuakeData;
  // Completer?? Why different from earlier methods?
  // What problem is it solving??
  Completer<GoogleMapController> _controller = Completer();
  // Set List of markers to empty, zero
  List<Marker> _markerList = <Marker>[];

  double _zoomVal = 2.0; // Initial zoom value
  // LatLng _initialPos = LatLng(51.4932646936, -0.1214661808);
  LatLng _initialPos = LatLng(36.5354538, -98.97494507); //

  // set initState
  @override
  void initState() {
    super.initState();
    // get earthquake from json API
    _earthQuakeData = Network().getAllQuakes();
    // _earthQuakeData.then(
    //     (value) => {print("Place: ${value.features[0].properties.place}")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [_displayGoogleMap(context), _zoomOut(), _zoomIn()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // print("Buttonpressed");
          getEarthQuakes();
        },
        label: Text("EarthQuakes"),
         icon: Icon(FontAwesomeIcons.mapMarked),
      ),
    );
  }

  void getEarthQuakes() {
    setState(() {
      _markerList.clear(); // Empty/Reset the marker List

      _getQuakesData();
    });
  }

  void _getQuakesData() {
    var _markerId;
    var _infoWindow;
    var _snippetTitle;
    var _lat;
    var _lng;

    setState(() {
      // TODO
      // _markerList.add(oklahomaMarker);
      // _markerList.add(puertoRicoMarker);
    });

    _earthQuakeData.then((quakes) => {
          print("quakes.features.length:  ${quakes.features.length}"),
          print("--------------------------------------"),
          quakes.features.forEach((element) => {
                _markerId = element.id,
                _infoWindow = element.properties.mag.toString(),
                _snippetTitle = element.properties.title,
                _lat = element.geometry.coordinates[1],
                _lng = element.geometry.coordinates[0],
                // print("markerId:  $_markerId"),
                // print("_infoWindow: $_infoWindow"),
                // print("Snippet title: $_snippetTitle"),
                // print("Latitude: $_lat"),
                // print("Longitude: $_lng"),
                // print("--------------------------------------"),
                _markerList.add(Marker(
                    markerId: MarkerId(_markerId),
                    position: LatLng(_lat, _lng),
                    infoWindow:
                        InfoWindow(title: _infoWindow, snippet: _snippetTitle),
                    icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueMagenta))),
              })
        });
  }
    Future<void> _minus(double zoomVal) async {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(36.5354538, -98.97494507), zoom: zoomVal)
        ));
    }
    Future<void> _plus(double zoomVal) async {
        final GoogleMapController controller = await _controller.future;
        controller.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(36.5354538, -98.97494507), zoom: zoomVal)
        ));
    }

    Widget _zoomOut() {
      return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            onPressed: () {
              _zoomVal--;
              _minus(_zoomVal);
            },
            // icon: Icon(Icons.search),
             icon: Icon(FontAwesomeIcons.searchMinus, color: Colors.black87,),
          ),
        ),
      );
    }

    Widget _zoomIn() {
      return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            onPressed: () {
              _zoomVal++;
              _plus(_zoomVal);
            },
            // icon: Icon(Icons.search),
             icon: Icon(FontAwesomeIcons.searchPlus, color: Colors.black87,),
          ),
        ),
      );
    }

  Widget _displayGoogleMap(context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: GoogleMap(
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition:
              CameraPosition(target: _initialPos, zoom: _zoomVal),
          // marker List initially empty
          markers: Set<Marker>.of(_markerList),
        ));


  }
  //-----------------------------

  // Marker oklahomaMarker = Marker(
  //     markerId: MarkerId("ok2021eeth"),
  //     position: LatLng(36.5354538, -98.97494507),
  //     infoWindow: InfoWindow(
  //         title: "M 2.5", snippet: "M 2.5 - 9 km WSW of Waynoka, Oklahoma"),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));

  // Marker puertoRicoMarker = Marker(
  //     markerId: MarkerId("pr2021059007"),
  //     position: LatLng(17.954, -66.8405),
  //     infoWindow: InfoWindow(
  //         title: "M 2.5", snippet: "M 2.5 - 4 km SSW of Indios, Puerto Rico"),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));

  // //-----------------------------
}
