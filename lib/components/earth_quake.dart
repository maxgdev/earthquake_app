import 'dart:async';

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
  //

  // GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  // Set List of markers to empty, zero
  List<Marker> _markerList = <Marker>[];

  double _zoomVal = 2.0; // Initial zoom value
  // LatLng _initialPos = LatLng(51.4932646936, -0.1214661808);

  LatLng _initialPos = LatLng(36.5354538, -98.97494507);

  // set initState
  @override
  void initState() {
    super.initState();
    // get earthquake from json API
    _earthQuakeData = Network().getAllQuakes();
    _earthQuakeData.then(
        (value) => {print("Place: ${value.features[0].properties.place}")});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _displayGoogleMap(context),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // print("Buttonpressed");
          getEarthQuakes();
        },
        label: Text("Show EarthQuakes"),
        icon: Icon(Icons.map_sharp),
      ),
    );
  }

  void getEarthQuakes() {
    setState(() {
      // _markerList.clear(); // Empty/Reset the marker List

      _getQuakesData();
    });
  }

  void _getQuakesData() {
    var _markerId;
    // var _position;
    var _infoWindow;
    // var _title;
    var _snippetTitle;
    var _lat;
    var _lng;

    setState(() {
      // TODO
      _markerList.add(oklahomaMarker);
      _markerList.add(puertoRicoMarker);
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
          print("markerId:  $_markerId"),
          print("_infoWindow: $_infoWindow"),
          print("Snippet title: $_snippetTitle"),
          print("Latitude: $_lat"),
          print("Longitude: $_lng"),
          print("--------------------------------------"),
        _markerList.add(
          Marker(
            markerId: MarkerId(_markerId),
            position: LatLng(_lat, _lng),
            infoWindow: InfoWindow(
              title: _infoWindow, snippet: _snippetTitle),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta))
        ),  
      })
    });
    // Print a value
    // _earthQuakeData.then((value) => {
    //       _markerId = value.features[0].id,
    //       _infoWindow = value.features[0].properties.mag.toString(),
    //       _snippetTitle = value.features[0].properties.title,
    //       _lat = value.features[0].geometry.coordinates[1],
    //       _lng = value.features[0].geometry.coordinates[0],
    //       print("value.features.length:  ${value.features.length}"),
    //       print("markerId:  $_markerId"),
    //       print("_infoWindow: $_infoWindow"),
    //       print("Snippet title: $_snippetTitle"),
    //       print("Latitude: $_lat"),
    //       print("Longitude: $_lng"),
    //     });
  }

  // Marker puertoRicoMarker = Marker(
  //     markerId: MarkerId("pr2021059007"),
  //     position: LatLng(17.954, -66.8405),
  //     infoWindow: InfoWindow(
  //         title: "M 2.5", snippet: "M 2.5 - 4 km SSW of Indios, Puerto Rico"),
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));

  // void _onMapCreated(GoogleMapController controller) {
  //   mapController = controller;
  // }

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
          // markers: {oklahomaMarker, puertoRicoMarker},
        ));
  }

  //-----------------------------

  Marker oklahomaMarker = Marker(
      markerId: MarkerId("ok2021eeth"),
      position: LatLng(36.5354538, -98.97494507),
      infoWindow: InfoWindow(
          title: "M 2.5", snippet: "M 2.5 - 9 km WSW of Waynoka, Oklahoma"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));

  Marker puertoRicoMarker = Marker(
      markerId: MarkerId("pr2021059007"),
      position: LatLng(17.954, -66.8405),
      infoWindow: InfoWindow(
          title: "M 2.5", snippet: "M 2.5 - 4 km SSW of Indios, Puerto Rico"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta));

  //-----------------------------
}
