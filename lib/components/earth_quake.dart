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
  Completer<GoogleMapController> _controller = Completer();
  // Set List of markers to empty, zero
  List<Marker> _markerList = <Marker>[];
  double _zoomVal = 5.0; // Initial zoom value
  // LatLng _initialPos = LatLng(51.4932646936, -0.1214661808);
  // Houses of Parliament ?? Duh no Earth Quakes in the UK
  // Also Data is US data? Double Duuuuhhh!!
  LatLng _initialPos = LatLng(60.0212, -153.0017);

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
      _markerList.clear(); // Empty/Reset the marker List
      _getQuakesData();
    });
  }

  void _getQuakesData() {
    setState(() {
    // TODO
    });
      _earthQuakeData.then((value) => {
        print(value.features[0].id),
        print(value.features[0].properties.mag.toString()),
        print(value.features[0].properties.title),
        print(value.features[0].geometry.coordinates[1]),
        print(value.features[0].geometry.coordinates[0]),
      });
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
          // markers: Set<Marker>.of(_markerList),
        ));
  }
}
